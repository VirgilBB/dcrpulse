# How to Submit Decred Pulse to Awesome-Akash

## 📋 Step-by-Step Guide

### 1. Fork the Repository

1. Go to https://github.com/akash-network/awesome-akash
2. Click the "Fork" button (top right)
3. Wait for GitHub to create your fork

### 2. Clone Your Fork

```bash
cd /Users/vb/akash
git clone https://github.com/VirgilBB/awesome-akash.git
cd awesome-akash
```

### 3. Create a New Branch

```bash
git checkout -b add-decred-pulse
```

### 4. Create Decred Pulse Directory

```bash
mkdir -p decred-pulse
cd decred-pulse
```

### 5. Copy Files

Copy the following files from `/Users/vb/akash/templates/decred/dcrpulse-akash/` to `awesome-akash/decred-pulse/`:

- `README.md`
- `deploy.yaml`
- `config.json`
- `decred.png`
- `COMMANDS.md` (recommended)

```bash
# From your akash directory
cp /Users/vb/akash/templates/decred/dcrpulse-akash/README.md awesome-akash/decred-pulse/
cp /Users/vb/akash/templates/decred/dcrpulse-akash/deploy.yaml awesome-akash/decred-pulse/
cp /Users/vb/akash/templates/decred/dcrpulse-akash/config.json awesome-akash/decred-pulse/
cp /Users/vb/akash/templates/decred/dcrpulse-akash/decred.png awesome-akash/decred-pulse/
cp /Users/vb/akash/templates/decred/dcrpulse-akash/COMMANDS.md awesome-akash/decred-pulse/
```

### 6. Add Decred Logo

`decred.png` is included in this package. Copy it into the target folder (shown above).

### 7. Commit Changes

```bash
cd /Users/vb/akash/awesome-akash
git add decred-pulse/
git commit -m "Add Decred Pulse deployment template

- Decred Pulse dashboard (web UI)
- Full Decred node (dcrd) backend
- Persistent storage for blockchain data
- P2P networking on port 9108
"
```

### 8. Push to Your Fork

```bash
git push origin add-decred-pulse
```

### 9. Create Pull Request

1. Go to your fork on GitHub: `https://github.com/YOUR_USERNAME/awesome-akash`
2. Click "Pull requests" tab
3. Click "New pull request"
4. Click "compare across forks"
5. Set:
   - **Base repository**: `akash-network/awesome-akash`
   - **Base branch**: `master` (or `main`)
   - **Head repository**: `YOUR_USERNAME/awesome-akash`
   - **Compare branch**: `add-decred-pulse`
6. Click "Create pull request"
7. Fill in the PR description:

```markdown
## Description

This PR adds Decred node deployment template to Awesome-Akash.

## What's Included

- Full Decred node (`dcrd`) deployment configuration
- Support for mainnet and testnet networks
- Persistent storage for blockchain data (120GB)
- RPC API access on port 9109
- P2P networking on port 9108
- Comprehensive README with setup instructions
- Configuration metadata in config.json

## Testing

- ✅ Deployed and tested on Akash mainnet
- ✅ Successfully syncs blockchain
- ✅ RPC API accessible and functional
- ✅ Persistent storage working correctly

## Resources

- Website: https://decred.org/
- Documentation: https://docs.decred.org/
- Block Explorer: https://dcrdata.decred.org/

## Category

Blockchain Node
```

### 10. Wait for Review

The Akash team will review your PR and may request changes. Be responsive to feedback!

## 📝 Checklist Before Submitting

- [ ] Fork created
- [ ] Branch created (`add-decred-pulse`)
- [ ] All files in `decred-pulse/` directory:
  - [ ] `README.md`
  - [ ] `deploy.yaml`
  - [ ] `config.json`
  - [ ] `decred.png`
  - [ ] `COMMANDS.md` (recommended)

- [ ] Files follow the format of other apps (Grafana, Balancer)
- [ ] Deployment tested on Akash
- [ ] Commit message is clear and descriptive
- [ ] Pull request description is complete

## 🎯 Tips for Success

1. **Test thoroughly** - Make sure your deployment works before submitting
2. **Follow existing patterns** - Look at other apps in awesome-akash for formatting
3. **Good documentation** - Clear README helps users
4. **Responsive** - Reply promptly to review comments
5. **Logo quality** - Use a high-quality, official Decred logo

## 📞 Need Help?

- **Akash Discord**: https://discord.gg/akash
- **Awesome-Akash Issues**: https://github.com/akash-network/awesome-akash/issues
- **Akash Docs**: https://docs.akash.network/

Good luck with your contribution! 🚀

