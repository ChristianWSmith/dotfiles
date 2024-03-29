#!/bin/bash
set -e

autologin_file="/etc/systemd/system/getty@tty1.service.d/autologin.conf"
sudo mkdir -p $(dirname $autologin_file)
sudo /bin/bash -c "rm -f $autologin_file; tee -a $autologin_file <<EOF
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --skip-login --nonewline --noissue --autologin $USER --noclear %I \\\$TERM
Environment=XDG_SESSION_TYPE=wayland
EOF" > /dev/null
sudo chmod 644 $autologin_file
sudo chown root:root $autologin_file
