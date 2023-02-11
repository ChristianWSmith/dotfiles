#!/bin/bash

pkill -x swaybg
swaybg -m fill -i $(~/.config/sway/scripts/helpers/random_bg.sh) &
