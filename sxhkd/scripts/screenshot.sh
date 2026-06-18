#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

case "$1" in
full)
    maim "$FILE"
    xclip -selection clipboard -t image/png -i "$FILE"
    notify-send "Captura" "Pantalla copiada al portapapeles"
    ;;

area)
    maim -s "$FILE"
    [ -f "$FILE" ] && xclip -selection clipboard -t image/png -i "$FILE"
    notify-send "Captura" "Selección copiada al portapapeles"
    ;;

*)
    echo "Uso: screenshot.sh [full|area]"
    exit 1
    ;;
esac
