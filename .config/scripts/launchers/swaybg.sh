#!/bin/bash

pkill -x swaybg
swaybg -m fill -i $(~/.config/scripts/helpers/random_bg.sh) &
