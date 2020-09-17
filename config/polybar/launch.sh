#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# polybar -rq music &
polybar -rq tray &
polybar -rq ws &
polybar -rq tray2 &
polybar -rq ws2 &
polybar -rq tray3 &
polybar -rq ws3 &


echo "Polybar launched..."
