#!/bin/bash
set -e

sudo usermod -a -G wheel $USER
sudo usermod -a -G seat $USER
sudo gpasswd -a $USER lp
sudo gpasswd -a $USER lpadmin
