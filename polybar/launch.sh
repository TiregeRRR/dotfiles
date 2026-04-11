#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit
#
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo $m
    if [[ $m == "HDMI-0" ]]; then 
      MONITOR=$m polybar -r main &
    fi
    if [[ $m == "DP-0" ]]; then
      MONITOR=$m polybar -r side &
    fi
    if [[ $m == "DP-2" ]]; then
      MONITOR=$m polybar -r side &
    fi
    #MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi

# Launch Polybar, using default config location ~/.config/polybar/config.ini
echo "Polybar launched..."
