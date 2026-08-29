------------------------------------------------------------
-- HYPRLAND CONFIG (Lua)
-- jhonatanoliveira2 on github / hyprland
-- Convertido de hyprland.conf (hyprlang) para hyprland.lua
-- Requer Hyprland >= 0.55. Vai em ~/.config/hypr/hyprland.lua
-- Ref: https://wiki.hypr.land/Configuring/Start/
------------------------------------------------------------


------------------
---- CORE --------
------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

hl.config({
    cursor = {
        no_hardware_cursors = 1,
    },
})


---------------------
---- MONITORS -------
---------------------

hl.monitor({
    output = "DP-1",
    mode = "1920x1200@60",
    position = "auto",
    scale = "auto",
})

hl.monitor({
    output = "DP-1",
    mode = "1920x1080@180",
    position = "auto",
    scale = 1,
})


-------------------------
---- ENVIRONMENT --------
-------------------------

hl.env("LANG", "pt_BR.UTF-8")
hl.env("LC_TIME", "pt_BR.UTF-8")

hl.env("XCURSOR_SIZE", "23")
hl.env("HYPRCURSOR_SIZE", "24")


---------------------
---- PROGRAMS -------
---------------------

local terminal = "kitty"
local fileManager = "thunar"
local menu = "wofi"


---------------------
---- AUTOSTART ------
---------------------

-- hl.exec_cmd("~/.config/hypr/scripts/layout.sh")

hl.on("hyprland.start", function()
    hl.exec_cmd(terminal)

    -- Waybar
    -- hl.exec_cmd("waybar")

    -- Clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)


-----------------
---- INPUT ------
-----------------

hl.config({
    input = {
        kb_layout = "us",

        follow_mouse = 1,
        sensitivity = -0.8,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})


------------------
---- LAYOUT ------
------------------

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 24,

        border_size = 2,

        resize_on_border = false,
        allow_tearing = false,

        layout = "dwindle",
    },
    master = {
        new_status = "master",
    },
})


-----------------------
---- DECORATIONS ------
-----------------------

hl.config({
    decoration = {
        rounding = 12,
        rounding_power = 3,

        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,

        dim_inactive = true,
        dim_strength = 0.08,

        shadow = {
            enabled = true,
            range = 20,
            render_power = 4,
            color = "rgba(000000aa)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.25,
            new_optimizations = true,
        },
    },
})


-----------------------
---- ANIMATIONS -------
-----------------------

hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("almostLinear", { type = "bezier", points = { {0.5, 0.5}, {0.75, 1} } })
hl.curve("quick", { type = "bezier", points = { {0.15, 0}, {0.1, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

hl.animation({ leaf = "border", enabled = true, speed = 6, bezier = "easeOutQuint" })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.5, bezier = "easeOutQuint", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "easeOutQuint", style = "popin 90%" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.7, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "quick" })

hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "linear", style = "fade" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2.2, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.2, bezier = "easeOutQuint", style = "slide" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })


----------------------------
---- WINDOW RULES ----------
----------------------------

-- Opacity rules

hl.window_rule({ match = { class = "vesktop" }, opacity = "0.96 0.88" })
hl.window_rule({ match = { class = "code" }, opacity = "0.90 0.85" })
hl.window_rule({ match = { class = "thunar" }, opacity = "0.80 0.65" })
hl.window_rule({ match = { class = "Thunar" }, opacity = "0.80 0.65" })
hl.window_rule({ match = { title = "micro" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { title = "Micro" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "zen" }, opacity = "1.00 0.90" })
hl.window_rule({ match = { class = "blueman-manager" }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "org.telegram.desktop" }, opacity = "0.90 0.80" })


------------------------------------
---- SPECIAL WINDOW RULES ----------
------------------------------------

hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})


------------------------
---- KEYBINDS ----------
------------------------

local mainMod = "SUPER"

-- Apps
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vesktop"))

-- Window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Exit
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))


-------------------------------------------------
---- WALLPAPER / PYWAL
---- DESATIVADO PARA TESTAR CAELESTIA
-------------------------------------------------

hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/awww/awww.sh"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("~/.config/waybar/wallpaper_script.sh"))

-- require("hyprland-colors") -- equivalente a "source = ~/.cache/wal/hyprland-colors.conf"


-------------------------
---- SCREENSHOT ---------
-------------------------

hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd("~/.local/bin/screenshot2.sh"))
hl.bind(mainMod .. " + SHIFT + Delete", hl.dsp.exec_cmd("~/.local/bin/screenshot.sh"))


---------------------
---- FOCUS ----------
---------------------

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))


----------------------
---- RESIZE ----------
----------------------

hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 40, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.resize({ x = -40, y = 0 }), { repeating = true })
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = -40 }), { repeating = true })
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = 40 }), { repeating = true })


-------------------------------------
---- SPECIAL WORKSPACE --------------
-------------------------------------

hl.bind(mainMod .. " + W", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + ALT + W", hl.dsp.window.move({ workspace = "m+" }))


-------------------------
---- WORKSPACES ---------
-------------------------

-- Troca de workspace com mainMod + [0-9]
-- Move a janela ativa para um workspace com mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 mapeia para a tecla 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end


------------------------------------
---- WORKSPACE SCROLL --------------
------------------------------------

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))


------------------------------------
---- MOUSE MOVE / RESIZE -----------
------------------------------------

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-------------------------
---- MEDIA KEYS ---------
-------------------------

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })


-------------------------
---- PLAYERCTL -----------
-------------------------

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


-----------------
---- MISC -------
-----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})


------------------------------------------------------------
-- CONFIGS DESATIVADAS
-- WAYBAR / PYWAL / WALLPAPERS
--
-- Tudo abaixo está preservado para reativação futura.
------------------------------------------------------------

----------------------
---- WAYBAR ----------
----------------------

-- NOTA: no .conf original esta linha estava ATIVA (fora do bloco de
-- comentário), mesmo estando na seção "desativada" -- provavelmente
-- sobrou de um teste. Mantive o mesmo comportamento aqui (waybar sobe
-- no start). Comente o bloco abaixo se isso não for intencional.
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
end)


-------------------------------------
---- WALLPAPERS / AWWW --------------
-------------------------------------

-- hl.on("hyprland.start", function()
--     hl.exec_cmd('sleep 3.0 && hyprctl dispatch exec "~/.config/awww/awww.sh"')
-- end)

-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/awww/awww.sh"))
-- hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("~/.config/waybar/wallpaper_script.sh"))


----------------------
---- PYWAL -----------
----------------------

-- require("hyprland-colors") -- equivalente a "source = ~/.cache/wal/hyprland-colors.conf"

-- hl.exec_cmd('wal -i "$WALLPAPER" -b "#000000" -n')

-- hl.exec_cmd("~/.config/mako/update-colors.sh")
-- hl.exec_cmd("~/.config/hypr/scripts/pywal-hyprland.sh")
-- hl.exec_cmd("~/.config/vscode-pywal-terminal.sh")
-- hl.exec_cmd("~/.config/micro/update_wal_micro.sh")
-- hl.exec_cmd("~/.config/scripts/update-cava.sh")
