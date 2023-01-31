#!/bin/bash

sudo usermod -a -G wheel $USER
sudo usermod -a -G seat $USER
sudo /bin/bash -c "rsync -a $HOME/.config/fish/ ~/.config/fish"

# TODO: inject literal '$TERM' into file
autologin_file="/etc/systemd/system/getty@tty1.service.d/autologin.conf"
sudo /bin/bash -c "rm -f $autologin_file; tee -a $autologin_file <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin $USER %I $(which $TERM)
Environment=XDG_SESSION_TYPE=wayland
EOF" > /dev/null
sudo chmod 644 $autologin_file
sudo chown root:root $autologin_file
