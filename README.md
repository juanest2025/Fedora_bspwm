# BSPWM Setup para Fedora - Guía de Instalación Completa

Setup personalizado de **bspwm** para Fedora con estética Tokyo Night/Catppuccin, maximizado para productividad y control total por teclado.

## Resumen del Stack

| Componente | Herramienta | Función |
|------------|------------|---------|
| Window Manager | **bspwm** | Gestor de ventanas tiling |
| Hotkeys | **sxhkd** | Atajos de teclado |
| Barra | **Polybar** | Panel de estado flotante |
| Compositor | **Picom** | Transparencias, sombras, esquinas redondeadas |
| Terminal | **Kitty** | Terminal GPU-acelerada |
| Launcher | **Rofi** | Menú de aplicaciones, power menu, config GUI |
| Notificaciones | **Dunst** | Sistema de notificaciones |
| Screenshots | **Maim + Xclip** | Capturas de pantalla |
| Bloqueo | **i3lock** / **i3lock-color** | Bloqueo de pantalla |
| Wallpaper | **Feh** | Fondo de pantalla |
| Clipboard | **Greenclip** | Historial de clipboard |
| Brillo | **brightnessctl** | Control de brillo |
| Audio | **PulseAudio/PipeWire** | Servidor de audio |
| File Manager | **Dolphin** | Navegador de archivos |
| Red | **NetworkManager** | Gestión de red |
| Temp. Color | **Redshift** | Protección de ojos |

---

## Requisitos Previos

- Fedora Workstation 38+ (probado en 39/40)
- Conexión a internet
- Acceso sudo
- $HOME debe ser `/home/tu-usuario`

---

## 1. Repositorios RPM Fusion

Algunos paquetes requieren repositorios adicionales:

```bash
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

---

## 2. Paquetes Principales

### BSPWM + Base del sistema
```bash
sudo dnf install bspwm sxhkd kitty rofi polybar dunst picom
```

### Herramientas de captura y bloqueo
```bash
sudo dnf install maim xclip i3lock
```

### Audio y dispositivos
```bash
sudo dnf install pavucontrol brightnessctl pulseaudio-utils playerctl
```

### Wallpaper y utilidades
```bash
sudo dnf install feh nitrogen redshift ImageMagick
```

### Herramientas de sistema
```bash
sudo dnf install xss-lock xdotool xprop xset xinput setxkbmap
```

### Bluetooth
```bash
sudo dnf install bluez bluez-tools
sudo systemctl enable --now bluetooth.service
```

### File manager
```bash
sudo dnf install dolphin
```

### Fuentes (Nerd Fonts)
```bash
sudo dnf install google-noto-sans-mono-fonts
```

Luego instalar **JetBrainsMono Nerd Font** y **MesloLGS NF** manualmente:

```bash
mkdir -p ~/.local/share/fonts
cd /tmp

# JetBrainsMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar xf JetBrainsMono.tar.xz -C ~/.local/share/fonts/

# MesloLGS NF (para Kitty)
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz
tar xf Meslo.tar.xz -C ~/.local/share/fonts/

fc-cache -fv
```

### Ícono Theme (Papirus-Dark)
```bash
sudo dnf install papirus-icon-theme
```

---

## 3. Flatpaks Recomendados

```bash
flatpak install flathub md.obsidian.Obsidian
flatpak install flathub org.telegram.desktop
flatpak install flathub app.zen_browser.zen
```

---

## 4. Navegadores

### Brave Browser
```bash
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
```

### Google Chrome
```bash
sudo dnf install fedora-workstation-repositories
sudo dnf config-manager --enable google-chrome
sudo dnf install google-chrome-stable
```

---

## 5. Clipboard Manager (Greenclip)

```bash
# Greenclip (binario pre-compilado)
wget -O /tmp/greenclip.tar.gz https://github.com/erebe/greenclip/releases/download/v4.2/greenclip.tar.gz
cd /tmp && tar xf greenclip.tar.gz
sudo mv greenclip /usr/local/bin/
chmod +x /usr/local/bin/greenclip
```

---

## 6. OpenTabletDriver (Opcional - Tablet Gráfica)

```bash
# Solo si usas tableta gráfica (Wacom, XP-Pen, etc.)
sudo dnf install opentabletdriver
sudo systemctl enable --now opentabletdriver.service
```

---

## 7. Configurar Touchpad

Crear archivo de configuración X11:

```bash
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo tee /etc/X11/xorg.conf.d/30-touchpad.conf << 'EOF'
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
    Option "AccelSpeed" "0.3"
EndSection
EOF
```

---

## 8. Copiar Dotfiles

```bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/Fedora_bspwm.git /tmp/Fedora_bspwm

# Crear directorios de configuración
mkdir -p ~/.config/{bspwm,sxhkd,kitty,polybar,picom,dunst,rofi}

# Copiar configuraciones
cp -r /tmp/Fedora_bspwm/bspwm/* ~/.config/bspwm/
cp -r /tmp/Fedora_bspwm/sxhkd/* ~/.config/sxhkd/
cp -r /tmp/Fedora_bspwm/kitty/* ~/.config/kitty/
cp -r /tmp/Fedora_bspwm/polybar/* ~/.config/polybar/
cp -r /tmp/Fedora_bspwm/picom/* ~/.config/picom/
cp -r /tmp/Fedora_bspwm/dunst/* ~/.config/dunst/
cp -r /tmp/Fedora_bspwm/rofi/* ~/.config/rofi/
cp /tmp/Fedora_bspwm/redshift.conf ~/.config/redshift.conf

# Dar permisos de ejecución
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/scripts/*
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/sxhkd/scripts/*
chmod +x ~/.config/rofi/launcher.sh
chmod +x ~/.config/rofi/powermenu.sh
chmod +x ~/.config/rofi/scripts/*
chmod +x ~/.config/rofi/sitios/*

# Wallpaper por defecto
mkdir -p ~/wallpaper
# Coloca tu wallpaper favorito en ~/wallpaper/default.jpg
```

---

## 9. Wallpaper Dinámico

El wallpaper dinámico cambia la imagen según la hora del día. Colocar imágenes en:

```
~/wallpaper/
├── 01_night.jpg       # 00:00 - 05:00
├── 02_sunrise.jpg     # 05:00 - 07:00
├── 03_morning.jpg     # 07:00 - 12:00
├── 04_afternoon.jpg   # 12:00 - 17:00
├── 05_evening.jpg     # 17:00 - 20:00
├── 06_night.jpg       # 20:00 - 00:00
└── default.jpg        # Wallpaper de respaldo
```

---

## 10. Iniciar BSPWM

### Desde Display Manager (GDM)

Al iniciar sesión, seleccionar **bspwm** en la pantalla de login (esquina inferior derecha).

### Desde TTY

```bash
# Iniciar X y bspwm
startx
```

Si no tienes `startx`, instalar xinit:

```bash
sudo dnf install xorg-x11-xinit
```

---

## 11. Atajos de Teclado Principales

| Atajo | Acción |
|-------|--------|
| `Super + Espacio` | Abrir Rofi (launcher) |
| `Super + Enter` | Abrir Kitty (terminal) |
| `Super + e` | Abrir Dolphin (file manager) |
| `Super + q` | Cerrar ventana |
| `Super + Shift + q` | Cerrar proceso |
| `Super + h/l` | Cambiar foco izquierda/derecha |
| `Super + j/k` | Cambiar foco abajo/arriba |
| `Super + Shift + h/l` | Mover ventana izquierda/derecha |
| `Super + Shift + j/k` | Mover ventana abajo/arriba |
| `Super + f` | Ventana fullscreen |
| `Super + t` | Ventana flotante |
| `Super + Shift + Space` | Toggle flotante |
| `AltGr + a/s/d/f/g/h/j/k/l` | Cambiar workspace 1-9 |
| `Ctrl+Shift+Up/Down` | Brillo +/- |
| `Ctrl+Shift+Right` | Volumen + |
| `Ctrl+Shift+Left` | Volumen - |
| `Ctrl+Shift+M` | Mute audio |
| `Super + p` | Power menu |
| `Print` | Screenshot selección |
| `Ctrl + Print` | Screenshot pantalla completa |
| `Super + Escape` | Bloquear pantalla |
| `Super + Shift + u` | Editar sxhkdrc con nvim |

---

## 12. Estructura de Archivos Instalados

```
~/.config/
├── bspwm/
│   ├── bspwmrc              # Autostart + config WM
│   ├── border_config.json   # Config animación de bordes
│   └── scripts/
│       ├── border_animator.py    # Animación de bordes
│       ├── bt-privacy.py         # Pausa BT al desconectar
│       ├── desktop_cycle.sh      # Ciclar workspaces
│       ├── desktop_navigation.sh # Navegación workspaces
│       ├── dynamic_wallpaper.sh  # Wallpaper dinámico
│       ├── fix_windows.sh        # Fix ventanas
│       ├── force_time_sync.sh    # Sync hora
│       ├── greenclip_wrapper.sh  # Clipboard manager
│       ├── lock.sh               # Lock screen mejorado
│       ├── screenshot_copy.sh    # Screenshots
│       └── toggle_opacity.sh     # Toggle transparencia
├── dunst/
│   └── dunstrc               # Config notificaciones
├── kitty/
│   ├── kitty.conf            # Config terminal
│   └── style.conf            # Esquema de colores
├── picom/
│   └── picom.conf            # Config compositor
├── polybar/
│   ├── config.ini            # Config barra
│   └── launch.sh             # Script de inicio
├── rofi/
│   ├── config.rasi           # Config principal
│   ├── clipboard.rasi        # Clipboard UI
│   ├── launcher.sh           # Launcher con i18n
│   ├── powermenu.sh          # Power menu con i18n
│   ├── scripts/
│   │   ├── config-menu.py    # GUI de configuración (1200+ líneas)
│   │   ├── powermenu.sh      # Power menu alternativo
│   │   └── wallpaper.sh      # Selector de wallpaper
│   └── sitios/
│       ├── sites.sh          # Accesos web (ES)
│       └── webs.sh           # Accesos web (EN)
└── sxhkd/
    ├── sxhkdrc               # Atajos de teclado
    └── scripts/
        ├── wifi.sh           # Gestión WiFi
        ├── mejorar.wifi.sh   # Mejorar señal WiFi
        ├── screenshot.sh     # Screenshots Wayland
        ├── toggle.sh         # Toggle utilities
        ├── wallpaper.sh      # Wallpaper setter
        ├── waybar.sh         # Waybar toggle (Wayland)
        └── random_wallpaper.sh # Wallpaper aleatorio
```

---

## 13. Esquema de Colores

La configuración usa una paleta **Tokyo Night / Catppuccin**:

| Color | Hex | Uso |
|-------|-----|-----|
| Fondo | `#0F0F0F` / `#1E1E2E` | Terminal / Polybar |
| Texto | `#CDD6F4` / `#E6E6E6` | Texto general |
| Azul | `#89B4FA` / `#7AA2F7` | Acento primario |
| Cyan | `#7DCFFF` | Acento secundario |
| Rosa | `#F7768E` | Alertas / errores |
| Verde | `#98C379` | Éxito |
| Amarillo | `#E5C07B` | Advertencia |
| Púrpura | `#BB9AF7` | Acento |

---

## 14. Solución de Problemas

### Polybar no aparece
```bash
polybar-msg cmd quit
~/.config/polybar/launch.sh
```

### No hay transparencias
```bash
# Verificar que picom está corriendo
pgrep picom || picom &
```

### Bordes no se animan
```bash
# Verificar dependencias Python
pip install dbus-python pygobject
```

### Notificaciones no aparecen
```bash
# Reiniciar dunst
pkill dunst && dunst &
```

### Wallpaper no se aplica
```bash
# Verificar que feh está instalado y el wallpaper existe
ls ~/wallpaper/default.jpg
feh --bg-fill ~/wallpaper/default.jpg
```

### Greenclip no funciona
```bash
# Iniciar daemon
greenclip daemon &
# Verificar
greenclip print
```

### Atajos no funcionan
```bash
# Reiniciar sxhkd
pkill sxhkd && sxhkd &
# O recargar
pkill -USR1 -x sxhkd
```

---

## 15. Notas

- **bspwm NO es un entorno de escritorio completo** - todo se configura manualmente.
- **sxhkd** controla todos los atajos de teclado.
- **Polybar** es la barra del sistema con módulos de bspwm, audio, red, batería, etc.
- **Picom** da efectos visuales: sombras, transparencias, esquinas redondeadas (radio: 12).
- **Rofi** tiene soporte multi-idioma (ES, EN, PT, FR, RU).
- La **config-menu.py** de rofi permite configurar idioma, teclado, cursor, polybar, picom, bspwm y wallpaper desde una GUI.
- El **border_animator.py** anima los bordes de las ventanas enfocadas con perfiles de color personalizables (blue_teal, cyberpunk, sunset, ocean).
- El setup tiene soporte dual **X11/Wayland** para screenshots y wallpaper (aunque bspwm es X11-only).
