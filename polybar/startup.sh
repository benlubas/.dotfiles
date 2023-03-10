#!/bin/bash

# Terminate already running bar instances
killall -q -r polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
polybar -r main 2>&1 | tee -a /tmp/polybar.log & disown
