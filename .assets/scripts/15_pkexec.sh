#!/bin/bash

~/.assets/pkexec-mask/pkexec-mask
sudo cp ~/.assets/pkexec-mask/pkexec-mask /usr/bin/pkexec-mask
sudo chmod --reference=$(which pkexec) /usr/bin/pkexec-mask
sudo chown --reference=$(which pkexec) /usr/bin/pkexec-mask
sudo mkdir -p /etc/pacman.d/hooks
sudo cp ~/.assets/pkexec-mask/pkexec-mask-install.hook /etc/pacman.d/hooks/pkexec-mask-install.hook
sudo cp ~/.assets/pkexec-mask/pkexec-mask-remove.hook /etc/pacman.d/hooks/pkexec-mask-remove.hook
