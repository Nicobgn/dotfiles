
#!/bin/bash

# Genera el nombre del archivo con timestamp
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S-%3N)
FILENAME="$HOME/Pictures/Screenshots/$TIMESTAMP.png"

# Crear la carpeta si no existe
mkdir -p "$HOME/Pictures/Screenshots"

# Dependiendo de la opción recibida, hacer una captura de pantalla
case $1 in
  "fullscreen")
    grim "$FILENAME" && cat "$FILENAME" | wl-copy
    ;;
  "region")
    grim -g "$(slurp)" "$FILENAME" && cat "$FILENAME" | wl-copy
    ;;
  "window")
    # Usamos hyprctl para obtener la información de la ventana enfocada
    WIN_GEOMETRY=$(hyprctl activewindow -j | jq -r '.geometry')
    grim -g "$WIN_GEOMETRY" "$FILENAME" && cat "$FILENAME" | wl-copy
    ;;
  *)
    echo "Usage: $0 {fullscreen|region|window}"
    exit 1
    ;;
esac

notify-send "Captura de Pantalla" "Se ha tomado la captura de pantalla y se guardó en $FILENAME"
