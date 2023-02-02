#!/bin/bash

pkill -x swaybg
backgrounds=($(find ~/.wallpapers | tr ' ' '\n'))


background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
swaybg -m fill -i $background &
