# ===== AUTO START HYPRLAND (TTY1) =====
if test -z "$WAYLAND_DISPLAY"; and test "$XDG_VTNR" = 1
    exec start-hyprland
end

if status is-interactive

    # PATH
    fish_add_path ~/.local/bin

    # ===== PYWAL =====
    if test -f "$HOME/.cache/wal/colors.fish"
        source "$HOME/.cache/wal/colors.fish"
    end

    # ===== FASTFETCH =====
    fastfetch

    # ===== ATUIN =====
    atuin init fish | source

    # ===== STARSHIP =====
    starship init fish | source

end
