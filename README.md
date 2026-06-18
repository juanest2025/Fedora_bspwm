🪟 BSPWM Setup on Fedora (Minimal + Efficient Rice)

Este es un setup mínimo para bspwm en Fedora, con herramientas esenciales para un entorno rápido, limpio y controlado por teclado.

📦 Paquetes incluidos
bspwm → window manager (tiling)
sxhkd → hotkeys
kitty → terminal
rofi → launcher
polybar → barra de estado
dunst → notificaciones
picom → compositor (transparencias y sombras)
dolphin → file manager
maim + xclip → screenshots + clipboard
i3lock → bloqueo de pantalla
🛠 Instalación en Fedora
1. RPM Fusion (recomendado)
sudo dnf install \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
2. Instalar paquetes
sudo dnf install bspwm sxhkd kitty rofi polybar dunst picom dolphin maim xclip i3lock
📁 Archivos de configuración
BSPWM

Ruta:

~/.config/bspwm/bspwmrc

Permisos:

chmod +x ~/.config/bspwm/bspwmrc
SXHKD

Ruta:

~/.config/sxhkd/sxhkdrc

Recargar hotkeys:

pkill -USR1 -x sxhkd
POLYBAR

Ruta:

~/.config/polybar/config.ini
~/.config/polybar/launch.sh

Permisos:

chmod +x ~/.config/polybar/launch.sh
PICOM

Ruta:

~/.config/picom/picom.conf
🚀 Autostart en bspwmrc
sxhkd &
picom &
dunst &
~/.config/polybar/launch.sh &
⌨️ Herramientas básicas
Launcher (rofi)
rofi -show drun
File manager (Dolphin)
dolphin
Screenshots (maim + clipboard)

Pantalla completa:

maim | xclip -selection clipboard -t image/png

Selección:

maim -s | xclip -selection clipboard -t image/png
Bloqueo de pantalla
i3lock
🧠 Notas importantes
bspwm NO es un entorno de escritorio completo.
Todo se configura manualmente.
sxhkd controla los atajos.
polybar es la barra del sistema.
picom da efectos visuales.
⚡ Extras recomendados
sudo dnf install nitrogen feh pavucontrol brightnessctl
