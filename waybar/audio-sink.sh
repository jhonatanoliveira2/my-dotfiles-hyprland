#!/bin/bash
# ~/.config/waybar/audio-sink.sh

sink=$(pactl get-default-sink 2>/dev/null)

if [[ -z "$sink" ]]; then
    printf '{"text":"󰝟","tooltip":"Sem áudio"}\n'
    exit 0
fi

case "${sink,,}" in          # ${,,} = lowercase, elimina duplicar *hdmi*|*HDMI*
  *hdmi*|*display*)          icon="󰡁" ;;
  *blue*|*bluez*|*bluetooth*)icon="󰂰" ;;
  *usb*|*headset*|*headphone*)icon="󰋋" ;;
  *)                         icon="󰓃" ;;
esac

desc=$(pactl list sinks 2>/dev/null | awk -v name="$sink" '
  /^Sink #/                             { in_block = 0 }
  /^[[:space:]]+Name:/                  { in_block = ($NF == name) }
  in_block && /^[[:space:]]+Description:/ {
    sub(/^[[:space:]]+Description:[[:space:]]*/, "")
    print; exit
  }
')

[[ -z "$desc" ]] && desc="$sink"

# Escape JSON: backslash primeiro, depois aspas
desc="${desc//\\/\\\\}"
desc="${desc//\"/\\\"}"

printf '{"text":"%s","tooltip":"%s"}\n' "$icon" "$desc"
