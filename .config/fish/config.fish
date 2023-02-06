if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    if [ "$XDG_VTNR" = "1" ] && [ -z "$DISPLAY" ]
        while ! /usr/bin/sway 2>&1 > /dev/null; :; end
    end
    fish_add_path ~/.local/bin
    alias "fc" "footclient & disown"
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
         root=blue,black
         border=blue,black
         title=blue,black
         roottext=white,black
         window=blue,black
         textbox=white,black
         button=black,blue
         compactbutton=white,black
         listbox=white,black
         actlistbox=black,white
         actsellistbox=black,blue
         checkbox=blue,black
         actcheckbox=black,blue
         '"
alias "nmtui" '/bin/bash -c "NEWT_COLORS=$NEWT_COLORS nmtui"'
