#!/usr/bin/env bash

source ~/.cache/wal/colors.sh

cat > ~/.config/micro/colorschemes/wal.micro <<EOF
color-link default "$foreground,$background"
color-link comment "$color8"
color-link statement "$color1"
color-link type "$color4"
color-link constant.string "$color2"
color-link constant.numeric "$color5"
color-link identifier.function "$color6"
color-link operator "$color3"
color-link statusline "$foreground,$color0"
EOF

