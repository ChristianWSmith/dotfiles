#!/bin/bash

pkill dsl-server
unlink ~/.config/sway/active_layout
ln -s ~/.config/sway/layouts/default_layout ~/.config/sway/active_layout
swaymsg reload

