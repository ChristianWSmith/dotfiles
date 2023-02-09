#!/bin/bash

entries=(/boot/loader/entries/*)
kernel_options="quiet loglevel=3 vt.global_cursor_default=0 systemd.show_status=auto rd.udev.log_level=3 nowatchdog modprobe.blacklist=sp5100_tco audit=0"
option_keys=()
for token in ${kernel_options[@]}
do
    key=$(echo $token | cut -d'=' -f1)
    option_keys+=("$key")
done
for entry in ${entries[@]}
do
    sudo rm -f .tmp
    touch .tmp
    while IFS= read -r line
    do
        if [ $(echo $line | cut -d' ' -f1) = "options" ]
        then
            out_line=""
            for token in ${line[@]}
            do
                key=$(echo $token | cut -d'=' -f1)
                if ! [[ " ${option_keys[*]} " =~ " ${key} " ]]
                then
                    out_line="$out_line$token "
                fi
            done
            out_line="$out_line$kernel_options"
            echo "$out_line" >> .tmp
        else
            echo -e "$line" >> .tmp
        fi
    done < $entry
    sudo chmod 755 .tmp
    sudo chown root:root .tmp
    sudo mv .tmp $entry
done
