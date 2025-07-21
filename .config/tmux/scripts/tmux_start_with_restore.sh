#!/usr/bin/env bash

# Enhanced tmux startup script with proper session restoration
# This script ensures tmux sessions are properly restored on system startup

# for "true full screen" call the script with "fullscreen" as the first argument
TRUE_FULL_SCREEN="$1"

# Wait for system to be fully ready
sleep 5

# Function to check if tmux server is running
tmux_server_running() {
    tmux list-sessions >/dev/null 2>&1
}

# Function to start tmux with restoration
start_tmux_with_restore() {
    # Start tmux server if not running
    if ! tmux_server_running; then
        # Start tmux in detached mode first
        tmux new-session -d -s "startup_session" 
        
        # Wait a moment for tmux to initialize
        sleep 2
        
        # Check if there are saved sessions to restore
        if [ -f "/Users/admin/Developers/Tinkering/.dotfiles/.config/tmux/sessions/last" ]; then
            # Trigger restore
            tmux run-shell '/Users/admin/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh'
            
            # Wait for restore to complete
            sleep 3
            
            # Kill the temporary startup session if restore was successful
            if [ "$(tmux list-sessions | wc -l)" -gt 1 ]; then
                tmux kill-session -t "startup_session" 2>/dev/null || true
            fi
        fi
    fi
}

start_terminal_and_run_tmux() {
    # First ensure tmux is properly started with restoration
    start_tmux_with_restore
    
    # Then open Terminal and attach to tmux
    osascript <<-EOF
    tell application "Terminal"
        if not (exists window 1) then reopen
        activate
        set winID to id of window 1
        do script "tmux attach || tmux new-session" in window id winID
    end tell
EOF
}

resize_window_to_full_screen() {
    osascript <<-EOF
    tell application "Terminal"
        set winID to id of window 1
        tell application "Finder"
            set desktopSize to bounds of window of desktop
        end tell
        set bounds of window id winID to desktopSize
    end tell
EOF
}

resize_to_true_full_screen() {
    osascript <<-EOF
    tell application "Terminal"
        # waiting for Terminal.app to start
        delay 1
        activate
        # short wait for Terminal to gain focus
        delay 0.1
        tell application "System Events"
            keystroke "f" using {control down, command down}
        end tell
    end tell
EOF
}

main() {
    start_terminal_and_run_tmux
    if [ "$TRUE_FULL_SCREEN" == "fullscreen" ]; then
        resize_to_true_full_screen
    else
        resize_window_to_full_screen
    fi
}

# Log the startup attempt
echo "$(date): Starting tmux with restore" >> /tmp/tmux_startup.log

main
