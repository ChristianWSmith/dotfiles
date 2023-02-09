#!/bin/bash
set -e

~/.assets/bin/pkexec-mask
sudo cp ~/.assets/bin/pkexec-mask /usr/bin/pkexec-mask
sudo chmod --reference=$(which pkexec) /usr/bin/pkexec-mask
sudo chown --reference=$(which pkexec) /usr/bin/pkexec-mask
sudo mkdir -p /etc/pacman.d/hooks
sudo cp ~/.assets/hooks/pkexec-mask-install.hook /etc/pacman.d/hooks/pkexec-mask-install.hook
sudo cp ~/.assets/hooks/pkexec-mask-remove.hook /etc/pacman.d/hooks/pkexec-mask-remove.hook
