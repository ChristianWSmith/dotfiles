#!/bin/bash

pkill -x swaylock

source ~/.config/sway/scripts/helpers/adwaita_colors.sh

swaylock_command="swaylock "
swaylock_command="$swaylock_command --color $gray" #                  Turn the screen into the given color instead of white.
swaylock_command="$swaylock_command --ignore-empty-password" #           When an empty password is provided, do not validate it.
swaylock_command="$swaylock_command --show-failed-attempts" #            Show current count of failed authentication attempts.
swaylock_command="$swaylock_command --daemonize" #                       Detach from the controlling terminal after locking.
swaylock_command="$swaylock_command --hide-keyboard-layout" #            Hide the current xkb layout while typing.
swaylock_command="$swaylock_command --scaling fill" #                  Image scaling mode: stretch, fill, fit, center, tile, solid_color.
swaylock_command="$swaylock_command --bs-hl-color $yellow" #            Sets the color of backspace highlight segments.
swaylock_command="$swaylock_command --caps-lock-bs-hl-color $yellow" #  Sets the color of backspace highlight segments when Caps Lock is active.
swaylock_command="$swaylock_command --caps-lock-key-hl-color $green" # Sets the color of the key press highlight segments when Caps Lock is active.
swaylock_command="$swaylock_command --inside-color $transparent" #           Sets the color of the inside of the indicator.
swaylock_command="$swaylock_command --inside-clear-color $transparent" #     Sets the color of the inside of the indicator when cleared.
swaylock_command="$swaylock_command --inside-caps-lock-color $transparent" # Sets the color of the inside of the indicator when Caps Lock is active.
swaylock_command="$swaylock_command --inside-ver-color $transparent" #       Sets the color of the inside of the indicator when verifying.
swaylock_command="$swaylock_command --inside-wrong-color $transparent" #     Sets the color of the inside of the indicator when invalid.
swaylock_command="$swaylock_command --key-hl-color $green" #           Sets the color of the key press highlight segments.
swaylock_command="$swaylock_command --layout-bg-color $transparent" #        Sets the background color of the box containing the layout text.
swaylock_command="$swaylock_command --layout-border-color $transparent" #    Sets the color of the border of the box containing the layout text.
swaylock_command="$swaylock_command --layout-text-color $transparent" #      Sets the color of the layout text.
swaylock_command="$swaylock_command --line-color $gray" #             Sets the color of the line between the inside and ring.
swaylock_command="$swaylock_command --line-clear-color $gray" #       Sets the color of the line between the inside and ring when cleared.
swaylock_command="$swaylock_command --line-caps-lock-color $gray" #   Sets the color of the line between the inside and ring when Caps Lock is active.
swaylock_command="$swaylock_command --line-ver-color $gray" #         Sets the color of the line between the inside and ring when verifying.
swaylock_command="$swaylock_command --line-wrong-color $gray" #       Sets the color of the line between the inside and ring when invalid.
swaylock_command="$swaylock_command --ring-color $gray" #             Sets the color of the ring of the indicator.
swaylock_command="$swaylock_command --ring-clear-color $blue" #       Sets the color of the ring of the indicator when cleared.
swaylock_command="$swaylock_command --ring-caps-lock-color $transparent" #   Sets the color of the ring of the indicator when Caps Lock is active.
swaylock_command="$swaylock_command --ring-ver-color $blue" #         Sets the color of the ring of the indicator when verifying.
swaylock_command="$swaylock_command --ring-wrong-color $red" #       Sets the color of the ring of the indicator when invalid.
swaylock_command="$swaylock_command --separator-color $gray" #        Sets the color of the lines that separate highlight segments.
swaylock_command="$swaylock_command --text-color $transparent" #             Sets the color of the text.
swaylock_command="$swaylock_command --text-clear-color $transparent" #       Sets the color of the text when cleared.
swaylock_command="$swaylock_command --text-caps-lock-color $transparent" #   Sets the color of the text when Caps Lock is active.
swaylock_command="$swaylock_command --text-ver-color $transparent" #         Sets the color of the text when verifying.
swaylock_command="$swaylock_command --text-wrong-color $transparent" #       Sets the color of the text when invalid.

swaybg_file=""
for ps_token in $(ps -ef | grep swaybg)
do
    if test -f $ps_token
    then
        swaybg_file=$ps_token
        break
    fi
done

if [ "$swaybg_file" != "" ]
then
    echo "HERE"
    echo "$swaybg_file"
    swaylock_command="$swaylock_command --image $swaybg_file"
else
    backgrounds=(~/.wallpapers*)
    if [ "$backgrounds" != "" ]
    then
        background=${backgrounds[$RANDOM%${#backgrounds[@]}]}
        swaylock_command="$swaylock_command --image $background"
    fi
fi

$swaylock_command &
