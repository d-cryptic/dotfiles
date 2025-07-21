#!/usr/bin/env bash

# Script to manually save tmux sessions
# Usage: ./save_session.sh

echo "Saving tmux session..."
tmux run-shell '~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh'

# Wait a moment for save to complete
sleep 2

# Check if save was successful
if [ -f ~/Developers/Tinkering/.dotfiles/.config/tmux/sessions/last ]; then
    echo "✅ Session saved successfully!"
    echo "📁 Session files:"
    ls -la ~/Developers/Tinkering/.dotfiles/.config/tmux/sessions/
else
    echo "❌ Session save failed!"
    exit 1
fi
