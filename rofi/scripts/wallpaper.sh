#!/bin/bash

DIR="$HOME/wallpaper"

WALL=$(find "$DIR" -maxdepth 1 -type f | sed "s|$DIR/||" | rofi -dmenu -p "Wallpaper")

[ -z "$WALL" ] && exit

feh --bg-fill "$DIR/$WALL"
