#!/bin/bash

pkill -x swaybg
backgrounds=(~/.config/sway/backgrounds/*)

if [ "$backgrounds" != "$HOME/.config/sway/backgrounds/*" ]
then
	background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
	swaybg -m fill -i $background &
fi
