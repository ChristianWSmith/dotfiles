#!/bin/bash

sudo rm -f .tmp
touch .tmp
while IFS= read -r line
do
    key=$(echo "$line" | cut -d'=' -f1)
    if [ "$key" = "HOOKS" ]
    then
        new_line=$(echo $line | sed 's/udev/systemd fsck/g')
        new_line=$(echo $new_line | sed 's/\(.*\)fsck\(.*\)fsck\(.*\)/\1fsck\2\3/g')
        new_line=$(echo $new_line | sed 's/  / /g')
        echo $new_line >> .tmp
    else
        echo $line >> .tmp    
    fi
done < /etc/mkinitcpio.conf
sudo chmod 644 .tmp
sudo chown root:root .tmp
sudo mv .tmp /etc/mkinitcpio.conf
sudo mkinitcpio -P
