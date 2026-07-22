#!/bin/bash

chosen=$(printf " Bloquear\n Suspender\n Reiniciar\n⏻ Apagar\n Salir" | rofi -dmenu -i -p "Power")

case "$chosen" in
    " Bloquear")
        i3lock
        ;;
    " Suspender")
        systemctl suspend
        ;;
    " Reiniciar")
        systemctl reboot
        ;;
    "⏻ Apagar")
        systemctl poweroff
        ;;
    " Salir")
        bspc quit
        ;;
esac
