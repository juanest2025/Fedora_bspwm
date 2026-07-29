#!/usr/bin/env bash

set -e

DIR="$HOME/Pictures/Screenshots"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

mkdir -p "$DIR"

case "$1" in
    full)
        maim -u "$FILE"
        ;;
    area)
        maim -s -u "$FILE"
        ;;
    window)
        maim -i "$(xdotool getactivewindow)" -u "$FILE"
        ;;
    *)
        echo "Uso: $0 {full|area|window}"
        exit 1
        ;;
esac

# Copiar al portapapeles
xclip -selection clipboard -t image/png < "$FILE"

# Notificación
notify-send \
    -i "$FILE" \
    "📸 Captura realizada" \
    "$(basename "$FILE")"

exit 0
