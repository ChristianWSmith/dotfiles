#!/bin/bash

(pfetch; echo "Updating...") | lolcat

if yay -Syu --needed --norebuild --noredownload --nocleanmenu --nodiffmenu --noremovemake
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
printf "Press any key to continue..."; read -n1 -p ""
