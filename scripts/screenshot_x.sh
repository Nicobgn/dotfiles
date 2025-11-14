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
    if scrot "$FILENAME" && \
       xclip -selection clipboard -t image/png -i "$FILENAME"; then
      SUCCESS=1
    fi
    ;;

  "region")
    # Selección interactiva de región (-s)
    if scrot -s -f "$FILENAME" && \
       xclip -selection clipboard -t image/png -i "$FILENAME"; then
      SUCCESS=1
    fi
    ;;

  "window")
    # Ventana enfocada (-u / --focused)
    if scrot -u "$FILENAME" && \
       xclip -selection clipboard -t image/png -i "$FILENAME"; then
      SUCCESS=1
    fi
    ;;

  *)
    echo "Usage: $0 {fullscreen|region|window}"
    dunstify 1
    ;;
esac

if [ "$SUCCESS" -eq 1 ]; then
  dunstify -a "Captura de pantalla" "Se guardó en $FILENAME y se copió al portapapeles"
fi

