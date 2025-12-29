<p align="center">
  <img src="assets/decred-logo.jpg" alt="Decred logo" width="220" />
</p>

# Decred Pulse on Akash

Decred is an autonomous digital currency with a hybrid PoW/PoS consensus system, built to be a superior store of value. Running a full node strengthens the network's decentralization and security. **Decred Pulse** makes it easy to deploy your own full node and web dashboard on Akash Network with just a few clicks—no technical expertise required.

> **Decred Pulse** is an open-source project by [karamble](https://github.com/karamble). This Akash deployment uses the official [dcrpulse](https://github.com/karamble/dcrpulse) project.

## Features

- **Hybrid PoW/PoS Consensus**: Combines the security of Proof-of-Work with the governance of Proof-of-Stake
- **Community Governance**: Stakeholders vote on consensus rule changes and project treasury spending
- **Self-Funding**: Built-in treasury system funds ongoing development
- **Privacy Features**: Optional privacy transactions via CoinShuffle++
- **Lightning Network**: Support for instant, low-fee transactions
- **Watch-Only Wallet Monitoring**: Import Extended Public Keys (xpub) to monitor wallet balances and transactions without exposing private keys

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

- **Dashboard**: `http://<your-lease-ingress>/` (port 80) - No password required
- **RPC User**: `decred` (internal communication only)
- **RPC Password**: `decredpass` (⚠️ **Change this in production!**)
- **Storage**: 120Gi persistent storage
- **CPU**: 2.5 units
- **Memory**: 5Gi

## Usage

1. Deploy using the provided `deploy.yaml`
2. Wait for initial blockchain sync (may take several hours)
3. Open the dashboard URL from Akash Console (Leases → URI)
4. Monitor logs to track sync progress

### Watch-Only Wallet Monitoring

You can import an Extended Public Key (xpub) to monitor your Decred wallet without exposing private keys:

1. Access the dashboard and navigate to **Settings** → **Import Extended Public Key**
2. Paste your xpub (Decred mainnet xpubs start with `dpub`)
3. Provide a friendly account name
4. The wallet will automatically rescan the blockchain to find all historical transactions (typically 5-30 minutes)

**Note**: Watch-only wallets can monitor balances and transactions but **cannot spend funds**. This is a security feature that allows you to track your wallet activity without risking your private keys.

### Monitoring Sync Progress

The dashboard displays real-time sync progress with a percentage status bar and current block height. Simply open the dashboard URL from Akash Console (Leases → URI) to view your node's sync status.

Compare your node's block height with the network: https://dcrdata.decred.org/

## Security Note

⚠️ **Important**: The dashboard itself has no password protection and is publicly accessible via the ingress URL. The RPC password (`decredpass`) is used for internal communication between the dashboard and `dcrd` node. For production deployments, change the RPC password in `deploy.yaml` to secure the internal RPC connection.

## Need Help?

- **Direct Support**: Email cerebro@cerebro.host
- **Issues?** Open an issue in [this repository](https://github.com/VirgilBB/dcrpulse)
- **Questions?** Join [Akash Discord](https://discord.gg/akash)
- **Decred Support?** Join [Decred Discord](https://discord.gg/decred)

