#!/bin/bash

pkill -x swaylock
backgrounds=(~/.config/sway/backgrounds/*)

if [ "$backgrounds" != "$HOME/.config/sway/backgrounds/*" ]
then
	background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
	swaylock -s fill -i $background &
fi
