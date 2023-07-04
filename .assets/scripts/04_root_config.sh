#!/bin/bash
set -e

sudo /bin/bash -c "rsync -a $HOME/.config/fish/ ~/.config/fish"
sudo /bin/bash -c "rsync $HOME/.vimrc ~/.vimrc"
sudo /bin/bash -c "rsync $HOME/.bashrc ~/.bashrc"


sudo /bin/bash -c "rsync $HOME/.gtkrc-2.0 ~/.gtkrc-2.0"
sudo /bin/bash -c "rsync $HOME/.config/gtkrc-2.0 ~/.config/gtkrc-2.0"
sudo /bin/bash -c "rsync $HOME/.config/gtkrc ~/.config/gtkrc"

sudo /bin/bash -c "rsync -a $HOME/.config/gtk-2.0/ ~/.config/gtk-2.0"
sudo /bin/bash -c "rsync -a $HOME/.config/gtk-3.0/ ~/.config/gtk-3.0"
sudo /bin/bash -c "rsync -a $HOME/.config/gtk-4.0/ ~/.config/gtk-4.0"
sudo /bin/bash -c "rsync -a $HOME/.config/qt5ct/ ~/.config/qt5ct"
sudo /bin/bash -c "rsync -a $HOME/.config/qt6ct/ ~/.config/qt6ct"
