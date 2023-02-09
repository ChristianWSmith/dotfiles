#!/bin/bash

fsck_services=("/usr/lib/systemd/system/systemd-fsck@.service" "/usr/lib/systemd/system/systemd-fsck-root.service")
for file in ${fsck_services[@]}
do
    sudo rm -f .tmp
    touch .tmp
    while IFS= read -r line
    do
    key=$(echo $line | cut -d'=' -f1)
    if [ "$key" != "StandardOutput" ] && [ "$key" != "StandardError" ]
    then
        echo $line >> .tmp
    fi
        if [ "$line" = "[Service]" ]
        then
            echo "StandardOutput=null" >> .tmp
            echo "StandardError=journal+console" >> .tmp
        fi
    done < $file
    sudo chmod 644 .tmp
    sudo chown root:root .tmp
    sudo mv .tmp $file
done
