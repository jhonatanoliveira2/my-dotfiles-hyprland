#!/bin/bash

WALL_DIR="$HOME/wallpapers"

mapfile -t arquivos < <(find "$WALL_DIR" -type f)

selecionado=$(for arquivo in "${arquivos[@]}"; do
    nome=$(basename "$arquivo")
    echo -en "$nome\0icon\x1f$arquivo\n"
done | rofi -dmenu -i -p "Wallpaper" -show-icons)

if [ -n "$selecionado" ]; then
    for arquivo in "${arquivos[@]}"; do
        if [[ "$(basename "$arquivo")" == "$selecionado" ]]; then
            ~/.config/awww/awww2.sh "$arquivo"
            break
        fi
    done
fi
