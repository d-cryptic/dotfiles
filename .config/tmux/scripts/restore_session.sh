#!/usr/bin/env bash

# Script to manually restore tmux sessions
# Usage: ./restore_session.sh

echo "Restoring tmux session..."

# Check if there's a session to restore
if [ ! -f ~/Developers/Tinkering/.dotfiles/.config/tmux/sessions/last ]; then
    echo "❌ No saved session found!"
    echo "💡 Run save_session.sh first to save your current session."
    exit 1
fi

echo "📁 Found saved session:"
ls -la ~/Developers/Tinkering/.dotfiles/.config/tmux/sessions/last

tmux run-shell '~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh'

# Wait a moment for restore to complete
sleep 3

echo "✅ Session restore completed!"
echo "📊 Current sessions:"
tmux list-sessions
