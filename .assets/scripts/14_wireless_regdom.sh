#!/bin/bash
set -e

sudo /bin/bash -c "echo 'WIRELESS_REGDOM=\"US\"' > /etc/conf.d/wireless-regdom"
