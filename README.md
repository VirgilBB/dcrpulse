 # Decred Pulse on Akash

Decred is an autonomous digital currency. With a hybrid consensus system, it is built to be a superior store of value for generations to come. The project is designed to ensure that the people who work on Decred are the ones who make decisions. It is a self-funding and self-governing cryptocurrency with a focus on decentralization, security, and sustainability.

## Features

- **Hybrid PoW/PoS Consensus**: Combines the security of Proof-of-Work with the governance of Proof-of-Stake
- **Community Governance**: Stakeholders vote on consensus rule changes and project treasury spending
- **Self-Funding**: Built-in treasury system funds ongoing development
- **Privacy Features**: Optional privacy transactions via CoinShuffle++
- **Lightning Network**: Support for instant, low-fee transactions

## About This Deployment

This deployment runs **Decred Pulse (web dashboard) + a full Decred node (`dcrd`)** on Akash Network in **one container**, providing:

- **Full blockchain sync** and validation
- **Web dashboard** exposed on port **80**
- **P2P networking** on port **9108**
- **Persistent storage** for blockchain data (PVC)

Why one container? Akash provisions per-service PVCs, so “shared volumes across services” don’t work the same as docker-compose. Combining the processes avoids that class of issues.

## Resources

- **Website**: https://decred.org/
- **Documentation**: https://docs.decred.org/
- **Block Explorer**: https://dcrdata.decred.org/
- **GitHub**: https://github.com/decred/dcrd

## Configuration

The deployment uses the following default settings:

- **Dashboard**: `http://<your-lease-ingress>/` (port 80)
- **RPC User**: `decred`
- **RPC Password**: `decredpass` (⚠️ **Change this in production!**)
- **Storage**: 120Gi persistent storage
- **CPU**: 2.5 units
- **Memory**: 5Gi

## Usage

1. Deploy using the provided `deploy.yaml`
2. Wait for initial blockchain sync (may take several hours)
3. Open the dashboard URL from Akash Console (Leases → URI)
4. Monitor logs to track sync progress

### Checking Sync Status (CLI)

You can check sync status from **Akash Console → Shell**:

### Quick Status Check

Check your node's current block height:

```bash
curl -sS -u decred:decredpass -H 'Content-Type: application/json' \
  -d '{"jsonrpc":"1.0","method":"getblockcount","params":[],"id":1}' \
  http://127.0.0.1:9109
```

Compare with network: https://dcrdata.decred.org/

**📖 See [COMMANDS.md](COMMANDS.md) for more commands.**

## Security Note

⚠️ **Important**: The default RPC password is for demonstration only. Please change it in `deploy.yaml` before deploying to production.

## Support

For issues with Decred itself, visit the [Decred Community](https://decred.org/community/).
For Akash deployment issues, visit the [Akash Discord](https://discord.gg/akash).

