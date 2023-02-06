#!/bin/bash

rm -f ~/.config/sway/display
/bin/bash -c 'tee -a ~/.config/sway/display <<EOF
set \$wsL "L"
set \$wsR "R"

output DP-1 pos 1920 0 res 1920x1080
output DP-2 pos 0 0 res 1920x1080
output DP-3 pos 3840 0 res 1920x1080

set \$monitor_left DP-2
set \$monitor_center DP-1
set \$monitor_right DP-3

workspace \$ws1 output \$monitor_center
workspace \$ws2 output \$monitor_center
workspace \$ws3 output \$monitor_center
workspace \$ws4 output \$monitor_center
workspace \$ws5 output \$monitor_center
workspace \$ws6 output \$monitor_center
workspace \$ws7 output \$monitor_center
workspace \$ws8 output \$monitor_center
workspace \$ws9 output \$monitor_center
workspace \$ws10 output \$monitor_center
workspace \$wsL output \$monitor_left
workspace \$wsR output \$monitor_right
EOF' > /dev/null
