#!/bin/bash

if (echo "Updating..."; pfetch; yay -Syu --needed --norebuild --noredownload --nocleanmenu --nodiffmenu --noremovemake; printf "Press any key to continue..."; read -n1 -p "") | lolcat
then
    notify-send -t 5000 "Update complete."
    text=""
    tooltip="Up to date."
else
    notify-send --urgency=critical -t 5000 "Update failed."
    text="⚠"
    tooltip="Update failed."
fi
echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}" > ~/.update_reminder
