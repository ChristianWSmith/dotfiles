#!/bin/bash

pkill -x waybar
waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &

