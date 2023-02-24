#!/bin/bash

if ! ps -ef | grep dsl-server | grep -v grep
then
    ~/.local/bin/dsl-server > ~/.dsl-server.log 2>&1 & disown
fi

unlink ~/.config/sway/active_layout
ln -s ~/.config/sway/layouts/dsl ~/.config/sway/active_layout
swaymsg reload

