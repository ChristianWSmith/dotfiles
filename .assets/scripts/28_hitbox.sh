#!/bin/bash
set -e

rules_file="/etc/udev/rules.d/hitbox.rules"
sudo /bin/bash -c "rm -f $rules_file; tee -a $rules_file <<EOF
ACTION==\"add\", ENV{ID_SERIAL}==\"DragonRise_Inc._Generic_USB_Joystick\", RUN+=\"/home/christian/.config/scripts/helpers/hitbox.sh\"
EOF" > /dev/null
sudo chmod 644 $rules_file
sudo chown root:root $rules_file
sudo udevadm control --reload-rules && sudo udevadm trigger
