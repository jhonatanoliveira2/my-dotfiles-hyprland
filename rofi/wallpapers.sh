#!/bin/bash

WALL_DIR="$HOME/wallpapers"

mapfile -t arquivos < <(find "$WALL_DIR" -type f)

nomes=$(printf "%s\n" "${arquivos[@]}" | awk -F/ '{print $NF}')

selecionado=$(printf "%s\n" "$nomes" | wofi --dmenu -p "Wallpaper")

if [ -n "$selecionado" ]; then
    for arquivo in "${arquivos[@]}"; do
        if [[ "$(basename "$arquivo")" == "$selecionado" ]]; then
            ~/.config/awww/awww2.sh "$arquivo"
            break
        fi
    done
fi
