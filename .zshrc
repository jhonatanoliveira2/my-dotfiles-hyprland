# Created by newuser for 5.9

# Pywal
[[ -f "$HOME/.cache/wal/colors.sh" ]] && source "$HOME/.cache/wal/colors.sh"

# Fastfetch
fastfetch

. "$HOME/.local/bin/env"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
eval "$(starship init zsh)"

# Dynamic System Paths
export WALLPAPER_DIR="/home/jhow/Pictures/Wallpapers"
export SCRIPT_DIR="/home/jhow/.config/hypr/scripts"
