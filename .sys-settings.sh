#!/bin/bash

sudo usermod -a -G wheel $USER
sudo usermod -a -G seat $USER
sudo /bin/bash -c "rsync -a $HOME/.config/fish/ ~/.config/fish"
