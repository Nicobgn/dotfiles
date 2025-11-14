#!/bin/bash 

BRIGHTNESS=${1:-0.7}
OUTPUT=$(xrandr | grep " connected" | awk '{print $1}' | head -n 1)

if [ -n "$OUTPUT" ]; then
    xrandr --output "$OUTPUT" --brightness "$BRIGHTNESS"
    dunstify "Brillo ajustado a $BRIGHTNESS en $OUTPUT"
else
    echo "No se detectó ningún monitor conectado."
fi

