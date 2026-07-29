#!/usr/bin/env bash

DIR="$HOME/Videos"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').mkv"

mkdir -p "$DIR"

case "$1" in

full)
    ffmpeg \
    -f x11grab \
    -video_size "$(xdpyinfo | awk '/dimensions/{print $2}')" \
    -framerate 60 \
    -i "$DISPLAY" \
    -f pulse \
    -i default \
    -c:v libx264 \
    -preset veryfast \
    -crf 23 \
    -c:a aac \
    "$FILE"
    ;;

area)
    GEOMETRY=$(slop -f "%x %y %w %h")

    read X Y W H <<< "$GEOMETRY"

    ffmpeg \
    -f x11grab \
    -video_size "${W}x${H}" \
    -i "$DISPLAY+$X,$Y" \
    -f pulse \
    -i default \
    -c:v libx264 \
    -preset veryfast \
    -crf 23 \
    -c:a aac \
    "$FILE"
    ;;

*)
    echo "Uso: $0 {full|area}"
    exit 1
    ;;

esac
