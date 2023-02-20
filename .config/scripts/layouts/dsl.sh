#!/bin/bash

if ! ps -ef | grep dsl-server | grep -v grep
then
    ~/.local/bin/dsl-server & disown
fi

unlink ~/.config/sway/active_layout
ln -s ~/.config/sway/layouts/dsl ~/.config/sway/active_layout
swaymsg reload

