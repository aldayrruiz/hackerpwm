#!/bin/bash

RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

while true; do
    NEW_RES=$(xrandr | grep '*' | awk '{print $1}')
    if [ "$NEW_RES" != "$RESOLUTION" ]; then
        # Reinicia Polybar
        ~/.config/polybar/launch.sh --forest &

        # Actualiza fondo de pantalla
        feh --bg-fill ~/Wallpapers/wallpaper.jpg &

        RESOLUTION=$NEW_RES
    fi
    sleep 2
done