#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
    jq -nc --arg text " " \
           --arg tooltip "Nenhuma música tocando" \
           '{text:$text, tooltip:$tooltip}'
    exit
fi

artist=$(playerctl metadata artist)
title=$(playerctl metadata title)
album=$(playerctl metadata album)
player=$(playerctl metadata playerName)

position=$(playerctl position 2>/dev/null)
length=$(playerctl metadata mpris:length)

length_sec=$((length/1000000))
pos_sec=${position%.*}

# função tempo
format_time() {
    printf "%02d:%02d" $(($1/60)) $(($1%60))
}

current=$(format_time $pos_sec)
total=$(format_time $length_sec)

# barra de progresso
bar_size=14
progress=$((pos_sec * bar_size / length_sec))

bar=""

for ((i=0;i<bar_size;i++)); do
    if [ $i -lt $progress ]; then
        bar+="─"
    elif [ $i -eq $progress ]; then
        bar+="●"
    else
        bar+="─"
    fi
done

if [[ "$status" == "Playing" ]]; then
    icon=""
else
    icon=""
fi

title_short=$(echo "$title" | cut -c1-25)

tooltip="󰲸 $title
 $artist

 $current / $total
$icon Status: $status"

text="$icon $title_short [$bar] $current"

jq -nc --arg text "$text" \
       --arg tooltip "$tooltip" \
       '{text:$text, tooltip:$tooltip}'
