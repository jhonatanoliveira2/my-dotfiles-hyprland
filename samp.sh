#!/usr/bin/env bash

GTA_DIR="$HOME/Downloads/gta-mods"
export WINEPREFIX="$HOME/.wine-samp"
export WINEARCH=win32
export LD_PRELOAD=/usr/lib32/libproxychains4.so 

cd "$GTA_DIR" || exit 1

wine samp.exe
