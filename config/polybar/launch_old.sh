#!/usr/bin/env bash

# Terminate already running bar instances

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar future

echo "Bars launched..."
