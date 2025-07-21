# Tmux Session Persistence Setup

This README documents the complete setup for persistent tmux sessions that survive system restarts on macOS.

## 🚀 Quick Start

**TL;DR**: Your tmux sessions should now persist across reboots! Here's what was fixed:

1. ✅ **Enhanced startup script** - Better timing and error handling
2. ✅ **Improved LaunchAgent** - Proper environment and logging
3. ✅ **Session directory created** - Required folder structure
4. ✅ **Configuration optimized** - Better save/restore settings
5. ✅ **Helper scripts added** - Easy manual save/restore testing

**Test it now:**
```bash
# Save current session
~/.config/tmux/scripts/save_session.sh

# Restart your Mac, tmux should auto-start with your sessions restored!
```

## 🎯 Overview

This configuration uses `tmux-resurrect` and `tmux-continuum` plugins to automatically save and restore tmux sessions, windows, panes, and even running processes across system reboots.

## 🔄 What Was Changed

### Files Modified:
- **`.tmux.conf`** - Added better process restoration and save interval
- **`~/Library/LaunchAgents/Tmux.Start.plist`** - Enhanced with logging and environment

### Files Created:
- **`scripts/tmux_start_with_restore.sh`** - Enhanced startup script with proper timing
- **`scripts/save_session.sh`** - Manual save script with verification
- **`scripts/restore_session.sh`** - Manual restore script with status check
- **`sessions/`** - Directory for session snapshots (auto-created)
- **`README.md`** - This documentation file

## 📋 Features

- ✅ **Automatic session saving** every 15 minutes
- ✅ **Auto-restore on system startup** via macOS LaunchAgent
- ✅ **Manual save/restore scripts** for testing
- ✅ **Pane content preservation** (command history, output)
- ✅ **Process restoration** for common development tools
- ✅ **Vim/Neovim session integration**

## 🔧 Configuration Files

### Main Configuration
- **`.tmux.conf`** - Main tmux configuration with plugin settings
- **`sessions/`** - Directory where session snapshots are stored
- **`scripts/`** - Helper scripts for manual operations

### Key Settings in `.tmux.conf`
```bash
# Session persistence plugins
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

# Persistence configuration
set -g @resurrect-dir '~/Developers/Tinkering/.dotfiles/.config/tmux/sessions/'
set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session'
set -g @resurrect-strategy-vim 'session'
set -g @resurrect-processes 'ssh psql mysql sqlite3 irb pry "~rails server" "~rails console"'
set -g @continuum-restore 'on'
set -g @continuum-boot 'on'
set -g @continuum-save-interval '15'

# Manual keybindings
set -g @resurrect-save 'm'
set -g @resurrect-restore 'n'
```

## 🚀 Installation & Setup

### Prerequisites
- tmux installed (`brew install tmux`)
- tmux plugin manager (TPM) installed

### Step-by-Step Setup

#### 1. Install Plugins
```bash
# In tmux session, press: Ctrl-s + I (to install plugins)
# Or reload config manually:
tmux source-file ~/.config/tmux/.tmux.conf
```

#### 2. Create Required Directories
```bash
mkdir -p ~/Developers/Tinkering/.dotfiles/.config/tmux/sessions/
mkdir -p ~/.config/tmux/scripts/
```

#### 3. Set Script Permissions
```bash
chmod +x ~/.config/tmux/scripts/*.sh
```

#### 4. Verify LaunchAgent (macOS)
```bash
# Check if LaunchAgent is loaded
launchctl list | grep -i tmux

# Should show: Tmux.Start.plist with status 0
```

#### 5. Test the Setup
```bash
# 1. Create some tmux sessions with multiple windows/panes
tmux new-session -d -s "test-session"
tmux new-window -t "test-session" -n "window2"

# 2. Save manually to test
~/.config/tmux/scripts/save_session.sh

# 3. Kill tmux server
tmux kill-server

# 4. Test restore
~/.config/tmux/scripts/restore_session.sh

# 5. Verify sessions are back
tmux list-sessions
```

#### 6. Test Auto-Startup (Optional)
```bash
# Test the startup script manually
~/.config/tmux/scripts/tmux_start_with_restore.sh

# Check logs
cat /tmp/tmux_startup.log
```

## 📝 Usage

### Manual Operations

#### Save Current Session
```bash
# Using script
~/.config/tmux/scripts/save_session.sh

# Using tmux keybinding
# Press: Ctrl-s + m
```

#### Restore Session
```bash
# Using script
~/.config/tmux/scripts/restore_session.sh

# Using tmux keybinding  
# Press: Ctrl-s + n
```

### Automatic Operations

- **Auto-save**: Sessions automatically save every 15 minutes
- **Auto-restore**: Sessions restore automatically on system startup
- **Boot integration**: tmux starts automatically when you log in

## 🔍 Troubleshooting

### Check if Sessions are Being Saved
```bash
ls -la ~/Developers/Tinkering/.dotfiles/.config/tmux/sessions/
```
You should see files like:
- `last` (symlink to latest session)
- `tmux_resurrect_YYYYMMDDTHHMMSS.txt` (session snapshots)
- `pane_contents.tar.gz` (pane content archives)

### Check LaunchAgent Status
```bash
# List loaded agents
launchctl list | grep -i tmux

# Check agent details
launchctl list Tmux.Start.plist
```

### View Startup Logs
```bash
# Startup script logs
cat /tmp/tmux_startup.log

# LaunchAgent error logs
cat /tmp/tmux_start.err

# LaunchAgent output logs  
cat /tmp/tmux_start.out
```

### Test Manual Startup
```bash
# Test the enhanced startup script
~/.config/tmux/scripts/tmux_start_with_restore.sh
```

### Common Issues & Solutions

#### 1. Sessions Not Saving
- Check if tmux-resurrect plugin is loaded: `tmux show-options -g | grep resurrect`
- Verify directory permissions: `ls -la ~/.config/tmux/sessions/`
- Try manual save: `~/.config/tmux/scripts/save_session.sh`

#### 2. Auto-restore Not Working
- Check LaunchAgent is loaded: `launchctl list | grep -i tmux`
- Verify script permissions: `ls -la ~/.config/tmux/scripts/`
- Check startup logs: `cat /tmp/tmux_startup.log`

#### 3. LaunchAgent Issues
```bash
# Reload LaunchAgent
launchctl unload ~/Library/LaunchAgents/Tmux.Start.plist
launchctl load ~/Library/LaunchAgents/Tmux.Start.plist

# Check LaunchAgent file
cat ~/Library/LaunchAgents/Tmux.Start.plist
```

#### 4. Processes Not Restoring
Add your specific processes to the resurrect-processes list in `.tmux.conf`:
```bash
set -g @resurrect-processes 'ssh psql mysql sqlite3 irb pry "~your-process"'
```

## 🛠 Advanced Configuration

### Disable Auto-restore Temporarily
Create a halt file to prevent auto-restore:
```bash
touch ~/tmux_no_auto_restore
```
Remove the file to re-enable auto-restore.

### Custom Save Interval
Change the auto-save interval (in minutes):
```bash
set -g @continuum-save-interval '30'  # Save every 30 minutes
```

### Exclude Specific Processes
To prevent certain processes from being restored:
```bash
set -g @resurrect-processes 'false'  # Disable all process restoration
```

## 📁 File Structure
```
.config/tmux/
├── .tmux.conf                          # Main configuration
├── README.md                           # This file
├── sessions/                           # Session snapshots
│   ├── last -> tmux_resurrect_*.txt   # Latest session symlink
│   ├── tmux_resurrect_*.txt           # Session snapshots
│   ├── pane_contents.tar.gz           # Pane content archives
│   └── save/                          # Temporary save directory
├── scripts/                           # Helper scripts
│   ├── tmux_start_with_restore.sh     # Enhanced startup script
│   ├── save_session.sh                # Manual save script
│   └── restore_session.sh             # Manual restore script
└── plugins/                           # Plugin directory
    ├── tpm/                           # Plugin manager
    ├── tmux-resurrect/                # Session persistence
    └── tmux-continuum/                # Auto-save/restore
```

## 🔗 References

- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
- [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)
- [TPM (Tmux Plugin Manager)](https://github.com/tmux-plugins/tpm)

---

**Last Updated**: July 2025  
**Tested On**: macOS with tmux 3.x
