#!/bin/bash
# ~/.config/waybar/audio-sink-switch.sh

declare -A sink_map

# awk: reseta em cada bloco "Sink #", strip robusto de whitespace,
# filtra .monitor, saída tab-separada para o bash consumir
while IFS=$'\t' read -r name desc; do
    sink_map["$desc"]="$name"
done < <(
    pactl list sinks | awk '
        /^Sink #/                    { name = ""; desc = "" }
        /^[[:space:]]+Name:/         {
            sub(/^[[:space:]]+Name:[[:space:]]*/, "")
            name = $0
        }
        /^[[:space:]]+Description:/  {
            sub(/^[[:space:]]+Description:[[:space:]]*/, "")
            desc = $0
            if (name != "" && name !~ /\.monitor$/)
                printf "%s\t%s\n", name, desc
        }
    '
)

[[ ${#sink_map[@]} -eq 0 ]] && exit 1

chosen=$(printf '%s\n' "${!sink_map[@]}" | \
    wofi --dmenu \
         --prompt "󰓃  Saída:" \
         --width 500 \
         --lines "${#sink_map[@]}")

[[ -z "$chosen" ]] && exit 0

target="${sink_map[$chosen]}"
[[ -z "$target" ]] && exit 1

pactl set-default-sink "$target"

# Migra streams ativos para o novo sink (sem isso o áudio continua no antigo)
pactl list short sink-inputs | awk '{print $1}' | \
    xargs -r -I{} pactl move-sink-input {} "$target"

pkill -SIGRTMIN+8 waybar
