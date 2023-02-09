#!/bin/bash

sudo /bin/bash -c "rsync -a $HOME/.config/fish/ ~/.config/fish"
sudo /bin/bash -c "rsync $HOME/.vimrc ~/.vimrc"
sudo /bin/bash -c "rsync $HOME/.bashrc ~/.bashrc"
