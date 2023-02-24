#!/bin/bash

if ! which doas > /dev/null 2>&1
then
    "ERROR: opendoas not installed."
    exit 1
fi

if test -f /etc/doas.conf > /dev/null 2>&1
then
    escalate="doas"
else
    escalate="sudo"
fi

$escalate /bin/bash -c "echo 'permit persist :wheel' > /etc/doas.conf"
$escalate /bin/bash -c "ln -sf /usr/bin/doas /usr/bin/sudo"
$escalate /bin/bash -c "chown -c root:root /etc/doas.conf"
$escalate /bin/bash -c "chmod -c 0400 /etc/doas.conf"
