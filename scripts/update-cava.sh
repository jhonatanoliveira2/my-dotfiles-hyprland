#!/usr/bin/env bash

# carrega cores do pywal
source ~/.cache/wal/colors.sh

CONFIG="$HOME/.config/cava/config"

# aplica cores
sed -i "s/gradient_color_1 = .*/gradient_color_1 = '$color1'/" "$CONFIG"
sed -i "s/gradient_color_2 = .*/gradient_color_2 = '$color5'/" "$CONFIG"

# reinicia cava
pkill -USR1 cava
