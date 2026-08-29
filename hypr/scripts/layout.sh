#!/usr/bin/env bash
sleep 3

launch_app() {
    local rules="$1"
    local cmd="$2"
    hyprctl dispatch exec "$rules $cmd" &
    sleep 0.6
}

# ===== Workspace 2 =====
hyprctl dispatch focusmonitor HDMI-A-1
hyprctl dispatch workspace 2

#sleep 1.0 && hyprctl dispatch exec "~/.config/awww/awww.sh" && hyprctl dispatch exec "~/.config/scripts/update-cava.sh"

launch_app "[workspace 2 silent monitor HDMI-A-1 float size 80% 85% move 0% 0% pseudo]" "kitty --title btm -e btm"
launch_app "[workspace 2 silent monitor HDMI-A-1 float size 70% 80% move 80% 0% pseudo]" "kitty"
launch_app "[workspace 2 silent monitor HDMI-A-1 float size 60% 50% move 0% 50% pseudo]" "kitty --title Cmatrix -e cmatrix"
launch_app "[workspace 2 silent monitor HDMI-A-1 float; size 35% 40%; move 65% 0% pseudo]" "kitty --title Cava -e cava"
launch_app "[workspace 2 silent monitor HDMI-A-1 float size 35% 40% move 65% 80% pseudo]" \
"kitty --title TtyClock tty-clock -c"

hyprctl dispatch workspace 3

sleep 0.5

# ===== Workspace 3 =====

launch_app "[workspace 3 silent monitor HDMI-A-1 float; size 80% 85%; move 0% 0% pseudo]" "zen-browser"

sleep 2

hyprctl dispatch workspace 2

#~/.config/mako/update-colors.sh 
#~/.config/hypr/scripts/pywal-hyprland.sh 
#~/.config/vscode-pywal-terminal.sh 
#~/.config/micro/update_wal_micro.sh 
#~/.config/scripts/update-cava.sh 
