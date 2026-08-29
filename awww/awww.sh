#!/usr/bin/env bash

WALLPAPERS_DIR="$HOME/wallpapers"
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)

CURSOR=$(hyprctl cursorpos | tr -d ' ')
CX=${CURSOR%,*}
CY=${CURSOR#*,}

MON_WIDTH=$(hyprctl monitors | grep -m1 -oP '\d+x\d+' | cut -dx -f1 | head -n1)

[ -z "$MON_WIDTH" ] && MON_WIDTH=1920

if (( CX < MON_WIDTH )); then
    MONITOR="DP-1"
    LOCAL_X=$CX
    LOCAL_Y=$CY
else
    MONITOR="HDMI-A-1"
    LOCAL_X=$((CX - MON_WIDTH))
    LOCAL_Y=$CY
fi

OTHER=$([[ "$MONITOR" == "DP-1" ]] && echo "HDMI-A-1" || echo "DP-1")

[ -z "$LOCAL_X" ] && LOCAL_X=0
[ -z "$LOCAL_Y" ] && LOCAL_Y=0


awww img "$WALLPAPER" -o "$MONITOR" --transition-type grow --transition-pos "$LOCAL_X,$LOCAL_Y" --transition-duration 0.4 --transition-fps 180 --transition-step 10 --invert-y

awww img "$WALLPAPER" -o "$OTHER" --transition-type grow --transition-pos "$LOCAL_X,$LOCAL_Y" --transition-duration 0.4 --transition-fps 180 --transition-step 10 --invert-y

wal -i "$WALLPAPER" -b "#000000" -n &

wait

~/.config/mako/update-colors.sh &
~/.config/hypr/scripts/pywal-hyprland.sh &
~/.config/vscode-pywal-terminal.sh &
~/.config/micro/update_wal_micro.sh &
~/.config/scripts/update-cava.sh &

