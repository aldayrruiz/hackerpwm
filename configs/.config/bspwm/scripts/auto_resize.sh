#!/bin/bash

# This script listens for screen resolution changes and automatically applies the optimal resolution,
# restarts polybar, and updates the wallpaper. It is designed to be run in the background on startup.

OUTPUT="Virtual-1"

xev -root -event randr | while read -r line; do
    if echo "$line" | grep -q "RRScreenChangeNotify"; then
        # Espera breve para evitar condiciones de carrera
        sleep 0.2

        # Aplica resolución óptima
        xrandr --output "$OUTPUT" --auto

        # Reinicia polybar limpio
        polybar-msg cmd quit 2>/dev/null
        ~/.config/polybar/launch.sh --forest &

        # Actualiza fondo de pantalla
        feh --bg-fill ~/Wallpapers/wallpaper.jpg &

        # Debug opcional
        echo "[AUTO-RESIZE] Applied $(xrandr | grep '*' | head -n1)"
    fi
done
