#!/usr/bin/env bas
TMP="/tmp/wal-gray.png"

magick "$WALLPAPER" -colorspace Gray "$TMP"

/home/jhow/ani-tupi/venv/bin/python -m pywal \
    --backend colorthief \
    -i "$TMP" \
    -n
