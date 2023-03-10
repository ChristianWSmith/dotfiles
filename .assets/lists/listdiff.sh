#!/usr/bin/fish

cd ~/.assets/lists/
yay -Qe | cut -d' ' -f1 > package-list-tmp
pip list | cut -d' ' -f1 | tail -n+3 > pip-list-tmp

figlet PACKAGES | lolcat
diff package-list package-list-tmp
figlet PIP | lolcat
diff pip-list pip-list-tmp

rm package-list-tmp pip-list-tmp
