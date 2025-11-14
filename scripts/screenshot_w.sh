#!/bin/bash

# Genera el nombre del archivo con timestamp
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S-%3N)
# DIR="$HOME/Pictures/Screenshots"
DIR="$HOME/Imágenes/Capturas"
FILENAME="$DIR/$TIMESTAMP.png"

# Crear la carpeta si no existe
mkdir -p "$DIR"

SUCCESS=0

case "$1" in
  "fullscreen")
    # Pantalla completa
    if grim "$FILENAME" && wl-copy < "$FILENAME"; then
      SUCCESS=1
    fi
    ;;

  "region")
    # Región interactiva (slurp devuelve la geometría o falla si cancelás)
    if grim -g "$(slurp)" "$FILENAME" && wl-copy < "$FILENAME"; then
      SUCCESS=1
    fi
    ;;

  "window")
    # Ventana enfocada (asumiendo que .geometry ya viene en formato que grim entiende)
    WIN_GEOMETRY=$(hyprctl activewindow -j | jq -r '.geometry')
    if grim -g "$WIN_GEOMETRY" "$FILENAME" && wl-copy < "$FILENAME"; then
      SUCCESS=1
    fi
    ;;

  *)
    echo "Usage: $0 {fullscreen|region|window}"
    dunstify "Usage: $0 {fullscreen|region|window}"
    exit 1
    ;;
esac

if [ "$SUCCESS" -eq 1 ]; then
  dunstify -a "Captura de Pantalla" "Se ha tomado la captura y se guardó en $FILENAME"
fi

