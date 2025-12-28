# Testing Guide for Decred on Akash

This guide helps you test the **Decred Pulse (combined)** deployment before submitting to awesome-akash.

## 📋 Prerequisites

1. **Deployed Decred node** on Akash
2. **jq installed** (optional) for pretty-printing JSON:
   ```bash
   # macOS
   brew install jq
   
   # Linux
   apt-get install jq
   ```
3. **curl installed** (usually pre-installed)

## 🚀 Quick Test

### Step 1: Open Akash Console Shell

1. Go to your deployment in Akash Console
2. Click **Shell**

### Step 2: Quick RPC checks (localhost)

Inside the shell, run:

```bash
curl -sS -u decred:decredpass -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockcount","params":[],"id":1}' \
  http://127.0.0.1:9109
```

And:

```bash
curl -sS -u decred:decredpass -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getpeerinfo","params":[],"id":1}' \
  http://127.0.0.1:9109
```

**Expected Output:**
```
🧪 Testing Decred RPC Commands
================================

🔗 Testing connection to: http://127.0.0.1:9109

Test 1: Ping
✅ PASS - Node is responding

Test 2: Get Block Count
✅ PASS - Block height: 1018482

Test 3: Get Peer Count
✅ PASS - Connected peers: 8

Test 4: Get Best Block Hash
✅ PASS - Block hash: ae72f0074ec048b5...

Test 5: Get Node Info
✅ PASS - Node version: 1120000, Connections: 8

Test 6: Network Sync Status
   Your node:  1018482
   Network:    1018482
   Difference: 0 blocks
✅ PASS - Node is SYNCED

Test 7: getdifficulty
✅ PASS

================================
✅ All tests passed!
================================

📊 Summary:
   Node Height:     1018482
   Network Height:  1018482
   Peers:           8
   Version:         1120000
   URL:             http://127.0.0.1:9109

🎉 Your Decred node is working correctly!
```

## 🔍 Manual Testing

### Test Individual Commands

1. **Check block height:**
   ```bash
   curl -s -u decred:decredpass -X POST \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"1.0","method":"getblockcount","params":[],"id":1}' \
     http://127.0.0.1:9109
   ```

2. **Check peer count:**
   ```bash
   curl -s -u decred:decredpass -X POST \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"1.0","method":"getpeerinfo","params":[],"id":1}' \
     http://127.0.0.1:9109
   ```

3. **Get node info:**
   ```bash
   curl -s -u decred:decredpass -X POST \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"1.0","method":"getinfo","params":[],"id":1}' \
     http://127.0.0.1:9109
   ```

## ✅ Validation Checklist

Before submitting to awesome-akash, verify:

- [ ] **Deployment works** - Node starts successfully
- [ ] **RPC accessible** - Can connect via curl
- [ ] **Syncing works** - Block height increases
- [ ] **Peers connected** - At least 1-2 peers
- [ ] **Commands tested** - At least 5 commands from COMMANDS.md work
- [ ] **Documentation accurate** - All examples use correct syntax
- [ ] **Dashboard reachable** - Can load the web UI from the lease URI
- [ ] **Security warnings** - Password change warnings included

## 🐛 Troubleshooting

### Connection Refused
```bash
curl: (7) Failed to connect to X.X.X.X port XXXXX: Connection refused
```

**Fix:** Use Akash Console → Shell and test `http://127.0.0.1:9109` from inside the container; also check the service is running and logs for crashes.

### Authentication Failed
```bash
{"result":null,"error":{"code":-1,"message":"..."},"id":1}
```

**Fix:** Verify RPC credentials match deployment

### Node Not Synced
```
Difference: 1000 blocks
```

**Fix:** Wait for sync to complete (check logs)

### No Peers
```
Connected peers: 0
```

**Fix:** Check P2P port 9108 is exposed, wait a few minutes

## 📊 Performance Benchmarks

### Expected Sync Times
- **Initial sync**: 4-8 hours (depends on network)
- **Block interval**: ~5 minutes average
- **Peer count**: 4-12 typical

### Resource Usage
- **CPU**: ~1.5-2.0 units during sync
- **Memory**: ~2-3 GB
- **Storage**: ~15-20 GB (as of 2025)
- **Network**: ~5-10 MB/s during sync

## 📝 Testing Notes

Document your test results:

```
Deployment Date: ___________
Akash Provider: ___________
Initial Sync Time: ___________
Final Block Height: ___________
Peer Count: ___________
RPC Commands Tested: ___________
Issues Found: ___________
```

## 🎯 Next Steps

After successful testing:

1. ✅ All tests pass
2. ✅ Documentation is accurate
3. ✅ Commands work as documented
4. 🚀 **Ready to submit to awesome-akash!**

Follow [CONTRIBUTION_GUIDE.md](CONTRIBUTION_GUIDE.md) for submission instructions.

