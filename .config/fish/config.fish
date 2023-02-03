if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    if [ "$XDG_VTNR" = "1" ] && [ -z "$DISPLAY" ]
        /usr/bin/sway 2>&1 > /dev/null
    end
    fish_add_path ~/.local/bin
    alias "update-package-list" "yay -Qe | cut -d' ' -f1 > ~/.packages"
    alias "update-etc-environment" "cat /etc/environment > ~/.etc-environment"
    alias "update-pip-list" "pip list | tail -n +3 | cut -d' ' -f1 > ~/.pip-list"
    alias "shutdown" "systemctl poweroff --no-wall"
    alias "reboot" "systemctl reboot --no-wall --reboot"
    alias "baseline" "sudo timeshift --delete-all; sudo timeshift --create --comments 'base'"
    alias "chx" "chmod +x"
    alias "remove-orphans" "yay -Qdtq | yay -Rns -"
    alias "adopt-orphans" "pacman -Qdtq | pacman -D --asexplicit -"
    alias "current-bg" "~/.config/sway/scripts/helpers/current_swaybg.sh"
    alias "swaylock" "~/.config/sway/scripts/launchers/swaylock.sh"
end
set "NEWT_COLORS" "'
 13         root=blue,black
 12         border=blue,black
 11         title=blue,black
 10         roottext=white,black
  9         window=blue,black
  8         textbox=white,black
  7         button=black,blue
  6         compactbutton=white,black
  5         listbox=white,black
  4         actlistbox=black,white
  3         actsellistbox=black,blue
  2         checkbox=blue,black
  1         actcheckbox=black,blue
34          '"
alias "nmtui" '/bin/bash -c "NEWT_COLORS=$NEWT_COLORS nmtui"'
