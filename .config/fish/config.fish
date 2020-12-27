set fish_greeting

#function fish_prompt
	# requires JetBrains Mono
	#printf " \u2248 "
#end

set -x EDITOR nvim

set -x PATH $PATH ~/.local/bin


set -x GDK_BACKEND wayland
set -x MOZ_ENABLE_WAYLAND 1

set -x SDL_VIDEODRIVER wayland

set -x QT_QPA_PLATFORM wayland-egl
set -x QT_WAYLAND_FORCE_DPI physical
set -x QT_QPA_PLATFORM wayland
set -x QT_WAYLAND_DISABLE_WINDOWDECORATION 1
