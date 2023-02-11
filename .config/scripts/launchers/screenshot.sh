#!/usr/bin/fish

set dimensions "$(slurp -d)"

if [ "$dimensions" ]
    grim -g $dimensions - | wl-copy
    notify-send -t 5000 "Screenshot copied to clipboard."
else
    notify-send -t 5000 "Screenshot canceled."
end
