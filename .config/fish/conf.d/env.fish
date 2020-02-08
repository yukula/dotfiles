# Environment variables are located here due to my no-xorg-policy,
# so I can't use .profile and etc.
# Also keep in mind that wayland applications may use systemd environment
# : https://wiki.archlinux.org/index.php/Systemd/User#Environment_variables

# 'set --show' is a greate start for debugging.


#set -gx <<NEW_VARIABLE>> $PATH


set -gx PATH $HOME/.local/bin $PATH


set -gx EDITOR nvim

# Wayland specific
# https://wiki.archlinux.org/index.php/Wayland
# Wayland will be selected by default. Do not set GDK_BACKEND, it will break apps (e.g. Chromium and Electron).
# set -gx GDK_BACKEND wayland
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_QPA_PLATFORM wayland
set -gx QT_WAYLAND_FORCE_DPI physical
set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set -gx CLUTTER_BACKEND wayland
set -gx SDL_VIDEODRIVER wayland
set -gx WINIT_UNIX_BACKEND wayland
