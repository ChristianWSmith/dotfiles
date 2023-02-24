#!/bin/bash

if ! which doas > /dev/null 2>&1
then
    "ERROR: opendoas not installed."
    exit 1
fi

sudo /bin/bash -c "echo 'permit nopass :wheel' > /etc/doas.conf"
sudo /bin/bash -c "ln -sf /usr/bin/doas /usr/bin/sudo"
