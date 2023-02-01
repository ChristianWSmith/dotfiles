#!/bin/bash

# +USER GROUPS
sudo usermod -a -G wheel $USER
sudo usermod -a -G seat $USER
# -USER GROUPS

# +ROOT FISH
sudo /bin/bash -c "rsync -a $HOME/.config/fish/ ~/.config/fish"
# -ROOT FISH

# +AUTO LOGIN
autologin_file="/etc/systemd/system/getty@tty1.service.d/autologin.conf"
sudo /bin/bash -c "rm -f $autologin_file; tee -a $autologin_file <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --skip-login --nonewline --noissue --autologin $USER --noclear %I \\\$TERM
Environment=XDG_SESSION_TYPE=wayland
EOF" > /dev/null
sudo chmod 644 $autologin_file
sudo chown root:root $autologin_file
# -AUTO LOGIN

# +KERNEL OPTIONS
entries=(/boot/loader/entries/*)
kernel_options="quiet loglevel=3 systemd.show_status=auto rd.udev.log_level=3 vt.global_cursor_default=0"
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
# -KERNEL OPTIONS

# +SILENT PRINTK
sudo /bin/bash -c "echo 'kernel.printk = 3 3 3 3' > /etc/sysctl.d/20-quiet-printk.conf"
# -SILENT PRINTK

# +SILENT FSCK
sudo rm -f .tmp
touch .tmp
while IFS= read -r line
do
    key=$(echo "$line" | cut -d'=' -f1)
    if [ "$key" = "HOOKS" ]
    then
        new_line=$(echo $line | sed 's/udev/systemd fsck/g')
        echo $new_line >> .tmp
    else
        echo $line >> .tmp    
    fi
done < /etc/mkinitcpio.conf
sudo chmod 644 .tmp
sudo chown root:root .tmp
sudo mv .tmp /etc/mkinitcpio.conf
sudo mkinitcpio -P
# -SILENT FSCK

# +FSCK SERVICES
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
# -FSCK SERVICES
