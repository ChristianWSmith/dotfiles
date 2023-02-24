#!/bin/bash

if ! which doas > /dev/null 2>&1
then
    "ERROR: opendoas not installed."
    exit 1
fi

doas /bin/bash -c "echo 'permit persist :wheel' > /etc/doas.conf"
doas /bin/bash -c "ln -sf /usr/bin/doas /usr/bin/sudo"
