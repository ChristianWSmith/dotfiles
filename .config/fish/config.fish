if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    if [ "$XDG_VTNR" = "1" ] && [ -z "$DISPLAY" ]
        while true; ~/.config/scripts/launchers/sway.sh 2>&1 > /dev/null; end
        # while true; ~/.config/scripts/launchers/hyprland.sh 2>&1 > /dev/null; end
    end
    fish_add_path ~/.local/bin
    alias "fetch" "pfetch | lolcat -F 0.2"
    alias "fc" "footclient & disown"
    alias "update-crontab" "crontab -l > ~/.assets/lists/crontab-dump"
    alias "update-package-list" "yay -Qe | cut -d' ' -f1 > ~/.assets/lists/package-list"
    alias "update-etc-environment" "cat /etc/environment > ~/.assets/lists/etc-environment"
    alias "update-pip-list" "pip list | tail -n +3 | cut -d' ' -f1 > ~/.assets/lists/pip-list"
    alias "update-dump-all" "update-crontab; update-package-list; update-etc-environment; update-pip-list"
    alias "shutdown" "systemctl poweroff --no-wall"
    alias "reboot" "systemctl reboot --no-wall --reboot"
    alias "baseline" "sudo timeshift --delete-all; sudo timeshift --create --comments 'base'"
    alias "chx" "chmod +x"
    alias "remove-orphans" "~/.config/scripts/helpers/remove_orphans.sh"
    alias "adopt-orphans" "pacman -Qdtq | pacman -D --asexplicit -"
    alias "current-bg" "~/.config/scripts/helpers/current_swaybg.sh"
    alias "remove-bg" "~/.config/scripts/helpers/remove_bg.sh"
    alias "dolphin-sync" "~/.config/scripts/helpers/google_drive_sync_dir.sh ~/.local/share/dolphin-emu/GC/USA/Card\ A/"
    alias "mount-google-drive" "~/.config/scripts/helpers/mount_google_drive.sh"
    alias "unmount-google-drive" "~/.config/scripts/helpers/unmount_google_drive.sh"
    alias "google-drive-sync-file" "~/.config/scripts/helpers/google_drive_sync_file.sh"
    alias "google-drive-sync-dir" "~/.config/scripts/helpers/google_drive_sync_dir.sh"
    alias "clean-names" "~/.config/scripts/helpers/clean_names.sh"
    alias "rip-yt-music-playlist" "~/.config/scripts/helpers/rip-yt-music-playlist.sh"
    alias "sort-video-by-res" "~/.config/scripts/helpers/sort-video-by-res.sh"
    alias "swaylock" "~/.config/scripts/launchers/swaylock.sh"
    alias "ex" "~/.config/scripts/helpers/ex.sh"
    alias "update" "~/.config/scripts/helpers/update.sh"
    alias "ga" "git add --all"
    alias "gc" "git commit -m"
    alias "gp" "git push"
    alias "gr" "git restore $HOME"
    fetch
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
