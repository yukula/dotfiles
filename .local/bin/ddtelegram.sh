#!/bin/sh

if pidof telegram-desktop-bin > /dev/null; then
    echo '1'
    if [ -z $(swaymsg -t get_tree | grep -A 1 'telegramdesktop' | tail -n 1 | grep 'true') ]; then
        swaymsg '[app_id="telegramdesktop"] scratchpad show'
	swaymsg '[app_id="telegramdesktop"] floating toggle'
        swaymsg '[app_id="telegramdesktop"] move right'
        swaymsg '[app_id="telegramdesktop"] resize set width 550 px'
    else
        swaymsg '[app_id="telegramdesktop"] move scratchpad'
            fi
else
    echo '2'
    telegram-desktop
fi

