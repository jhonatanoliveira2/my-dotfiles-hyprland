#!/bin/bash

WALLPAPER="$1"

if [ -z "$WALLPAPER" ]; then
    WALLPAPERS_DIR="$HOME/wallpapers"
    WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
fi

CURSOR=$(hyprctl cursorpos | tr -d ' ')
CX=${CURSOR%,*}
CY=${CURSOR#*,}

# Detecta largura do monitor automaticamente 
if (( CX < 1920 )); then
    MONITOR="DP-1"
    LOCAL_X=$CX
    LOCAL_Y=$CY
else
    MONITOR="HDMI-A-1"
    LOCAL_X=$((CX - 1920))
    LOCAL_Y=$CY
fi

# Monitor principal
awww img "$WALLPAPER" -o "$MONITOR" --transition-type grow --transition-pos "$LOCAL_X,$LOCAL_Y" --transition-duration 0.2 --transition-fps 180 --transition-step 10 --invert-y

# Outro monitor
OTHER=$([[ "$MONITOR" == "DP-1" ]] && echo "HDMI-A-1" || echo "DP-1")

awww img "$WALLPAPER" -o "$OTHER" --transition-type grow --transition-pos "$LOCAL_X,$LOCAL_Y" --transition-duration 0.2 --transition-fps 300 --transition-step 10 

# Tudo pesado em background
wal -i "$WALLPAPER" -b "#000000" -n &

# espera o wal terminar
wait

~/.config/mako/update-colors.sh &
~/.config/hypr/scripts/pywal-hyprland.sh &
~/.config/vscode-pywal-terminal.sh &
~/.config/micro/update_wal_micro.sh &
~/.config/scripts/update-cava.sh &
