# Decred Pulse / dcrd Commands

Useful commands for managing and monitoring your Decred node deployed on Akash.

## 🔍 Prerequisites

You'll need:
- Akash Console access to your deployment
- Akash Console → **Shell**
- RPC credentials (default: `decred` / `decredpass`, set in `deploy.yaml`)

This template runs dcrd + the dashboard in one container. dcrd RPC is on `127.0.0.1:9109` (localhost).

---

## 📊 Monitoring Commands

### Check Current Block Height
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockcount","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Example Output:** `1018396`

---

### Get Node Info
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getinfo","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Returns:**
- Version
- Protocol version
- Block count
- Connection count
- Difficulty
- Network info

---

### Check Peer Connections
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getpeerinfo","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Shows:**
- Connected peers
- IP addresses
- Protocol versions
- Connection times

---

### Get Peer Count
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getpeerinfo","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Example Output:** `8` (number of connected peers)

---

## 🔗 Blockchain Query Commands

### Get Best Block Hash
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getbestblockhash","params":[],"id":1}' \
  http://127.0.0.1:9109
```

---

### Get Block by Height
```bash
# Replace 1018396 with desired block height
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockhash","params":[1018396],"id":1}' \
  http://127.0.0.1:9109
```

---

### Get Block Details
```bash
# First get block hash, then get block details
BLOCK_HASH=$(curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getbestblockhash","params":[],"id":1}' \
  http://127.0.0.1:9109)

curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d "{\"jsonrpc\":\"1.0\",\"method\":\"getblock\",\"params\":[\"$BLOCK_HASH\"],\"id\":1}" \
  http://127.0.0.1:9109
```

---

### Get Blockchain Info
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockchaininfo","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Shows:**
- Chain name
- Block count
- Best block hash
- Difficulty
- Verification progress
- Chain work

---

## 🌐 Network Commands

### Get Network Hash Rate
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getnetworkhashps","params":[],"id":1}' \
  http://127.0.0.1:9109
```

---

### Get Network Difficulty
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getdifficulty","params":[],"id":1}' \
  http://127.0.0.1:9109
```

---

### Check Network Status
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getnetworkinfo","params":[],"id":1}' \
  http://127.0.0.1:9109
```

---

## 🔧 Health Check Commands

### Simple Ping Test
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"ping","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Returns:** `{"result":null,"error":null,"id":1}` if healthy

---

### Connection Test
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getconnectioncount","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Returns:** Number of active connections

---

### Full Health Check Script
```bash
#!/bin/bash

URL="http://127.0.0.1:9109"
USER="decred"
PASS="decredpass"

echo "🏥 Decred Node Health Check"
echo "=============================="

# Block height
HEIGHT=$(curl -s -u $USER:$PASS -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockcount","params":[],"id":1}' \
  "$URL")
echo "📊 Block Height: $HEIGHT"

# Peer count
PEERS=$(curl -s -u $USER:$PASS -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getpeerinfo","params":[],"id":1}' \
  "$URL")
echo "🌐 Connected Peers: $PEERS"

# Network height
NETWORK_HEIGHT=$(curl -s https://dcrdata.decred.org/api/block/best/height)
echo "🌍 Network Height: $NETWORK_HEIGHT"

# Sync status
if [ "$HEIGHT" -ge "$((NETWORK_HEIGHT - 2))" ]; then
  echo "✅ Node is SYNCED"
else
  echo "⚠️  Node is SYNCING ($(($NETWORK_HEIGHT - $HEIGHT)) blocks behind)"
fi
```

---

## 📈 Comparison Commands

### Compare with Network
```bash
# Your node's height
MY_HEIGHT=$(curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockcount","params":[],"id":1}' \
  http://127.0.0.1:9109)

# Network height
NETWORK_HEIGHT=$(curl -s https://dcrdata.decred.org/api/block/best/height)

echo "Your node: $MY_HEIGHT"
echo "Network:   $NETWORK_HEIGHT"
echo "Difference: $(($NETWORK_HEIGHT - $MY_HEIGHT)) blocks"
```

---

## 🛠️ Troubleshooting Commands

### Test RPC Connection
```bash
# Test if RPC is accessible
curl -v -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getinfo","params":[],"id":1}' \
  http://127.0.0.1:9109
```

---

### Check RPC Methods Available
```bash
curl -s -u decred:decredpass -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"help","params":[],"id":1}' \
  http://127.0.0.1:9109
```

---

## 📝 Notes

### Security
- **Never expose your RPC password** in public scripts
- **Change default password** before production use
- **Use environment variables** for credentials:
  ```bash
  export DCRD_USER="decred"
  export DCRD_PASS="your_secure_password"
  curl -u $DCRD_USER:$DCRD_PASS ...
  ```

### Rate Limiting
- Be mindful of API call frequency
- Some providers may rate-limit RPC requests

### Akash Port Mapping
- RPC is bound to `127.0.0.1:9109` (localhost) by default for safety.
- Use **Akash Console → Shell** to run the commands in this document.

### Network Comparison
- Use https://dcrdata.decred.org/ to verify network state
- Allow 1-2 blocks difference for network propagation

---

## 🔗 Additional Resources

- **Decred RPC Documentation**: https://docs.decred.org/
- **JSON-RPC API**: https://github.com/decred/dcrd/blob/master/docs/json_rpc_api.mediawiki
- **dcrdata API**: https://github.com/decred/dcrdata#apis

---

## 💡 Quick Reference

Replace these in all commands:
- `127.0.0.1:9109` → Local RPC endpoint (use Akash Console → Shell)
- `decred:decredpass` → Your RPC credentials (set in `deploy.yaml`)

**Example:**
```bash
curl -s -u decred:mySecurePass123 -X POST \
  -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockcount","params":[],"id":1}' \
  http://127.0.0.1:9109
```

