#!/bin/bash
set -e

sudo /bin/bash -c "echo 'kernel.printk = 3 3 3 3' > /etc/sysctl.d/20-quiet-printk.conf"
