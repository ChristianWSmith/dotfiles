#!/bin/bash

pfetch | lolcat

do_update_mirrors=z

while [ "$do_update_mirrors" != "y" ] && [ "$do_update_mirrors" != "Y" ] && [ "$do_update_mirrors" != "n" ] && [ "$do_update_mirrors" != "N" ] && [ "$do_update_mirrors" != "" ]
do
    read -n1 -p "Update mirrorlist? [y/N] " do_update_mirrors
    echo ""
done

if [ "$do_update_mirrors" = "y" ] || [ "$do_update_mirrors" = "Y" ]
then
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.$(date +%s).old
    sudo reflector --connection-timeout 1 --download-timeout 1 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
fi

if yay -Syyuu --noconfirm
then
    notify-send -t 5000 "Update complete."
    text=""
    tooltip="Up to date."
else
    notify-send --urgency=critical -t 5000 "Update failed."
    text=""
    tooltip="Update failed."
fi
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}" > ~/.update_reminder
printf "Press any key to continue..."; read -n1 -p ""
