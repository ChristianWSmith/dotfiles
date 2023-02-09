#!/bin/bash
set -e

sudo /bin/bash -c 'echo -e "[connection]\nwifi.powersave = 2" > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf'
