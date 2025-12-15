# SnapShot - System State Snapshot and Comparison Tool

Know exactly what changed on your system! SnapShot captures system state and shows you precise before/after differences.

## Why SnapShot?

Ever wonder "What changed that broke my system?" SnapShot tells you exactly:
- 📸 **Capture system state** in seconds
- 🔍 **Compare snapshots** - see what changed
- 📦 **Track packages** - added/removed
- 🔧 **Monitor services** - started/stopped
- 🌐 **Watch ports** - new listeners
- 💾 **Lightweight** - just metadata, not full backups

## Installation

```bash
curl -sSL https://raw.githubusercontent.com/strabo231/snapshot/main/install.sh | bash
```

## Quick Start

```bash
# Before making changes
snapshot save before-upgrade

# Make your changes (system update, config edits, etc.)
sudo apt upgrade

# After changes
snapshot save after-upgrade

# See what changed
snapshot compare before-upgrade after-upgrade
```

## Commands

```bash
snapshot save <n>              # Take a snapshot
snapshot list                     # List all snapshots  
snapshot compare <snap1> <snap2>  # Compare two snapshots
snapshot delete <n>            # Delete a snapshot
```

## What Gets Captured

✅ Installed packages (dpkg/rpm)  
✅ Running services (systemd)  
✅ Listening ports (ss/netstat)  
✅ Disk usage (df)  
✅ Kernel version  
✅ User accounts  
✅ Network interfaces  

## Use Cases

**Before System Upgrade:**
```bash
snapshot save pre-upgrade-$(date +%Y%m%d)
sudo apt upgrade
snapshot save post-upgrade-$(date +%Y%m%d)
snapshot compare pre-upgrade-20241214 post-upgrade-20241214
```

**Troubleshooting:**
```bash
snapshot save working-state
# System breaks after some changes...
snapshot save broken-state
snapshot compare working-state broken-state
# See: "New services: malware.service" 😱
```

**Server Auditing:**
```bash
snapshot save monthly-$(date +%Y%m)
# Compare with last month to track drift
```

## Example Output

```
COMPARING: before-upgrade → after-upgrade

PACKAGES:
✓ Added: 23 packages
  + linux-image-6.5.0-15
  + python3.12
  + libssl3
  ... and 20 more

⚠ Removed: 2 packages
  - linux-image-6.2.0-10
  - oldpackage

SERVICES:
✓ New services running:
  + docker.service
  
PORTS:
ℹ No port changes
```

## License

MIT License - see [LICENSE](LICENSE)

## Author

Sean - [@strabo231](https://github.com/strabo231)

---

**Know what changed. Fix problems faster.** 🔍
