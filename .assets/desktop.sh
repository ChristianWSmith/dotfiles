#!/bin/bash
set -e

if [ "$EUID" -eq 0 ]
    then echo "Do not run as root."
    exit
fi

rm -f ~/.config/hypr/display.conf
/bin/bash -c 'tee -a ~/.config/hypr/display.conf <<EOF
monitor=DP-2, 1920x1080, 0x0, 1
monitor=DP-1, 1920x1080@240, 1920x0, 1
monitor=DP-3, 1920x1080, 3840x0, 1

workspace=11,monitor:DP-2
workspace=12,monitor:DP-3
workspace=1,monitor:DP-1
workspace=2,monitor:DP-1
workspace=3,monitor:DP-1
workspace=4,monitor:DP-1
workspace=5,monitor:DP-1
workspace=6,monitor:DP-1
workspace=7,monitor:DP-1
workspace=8,monitor:DP-1
workspace=9,monitor:DP-1
workspace=10,monitor:DP-1
EOF' > /dev/null

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

assign [class="Google-Chrome" instance="messenger.com__login"] workspace \$wsR
assign [class="Google-Chrome" instance="discord.com__login"] workspace \$wsR
EOF' > /dev/null

sudo /bin/bash -c 'rm -f /etc/modprobe.d/88x2bu.conf; tee -a /etc/modprobe.d/88x2bu.conf <<EOF
# /etc/modprobe.d/88x2bu.conf
#
# Purpose: Allow easy access to specific driver options.
#
# Edit the following line to change, add or delete options:
options 88x2bu rtw_drv_log_level=0 rtw_led_ctrl=1 rtw_vht_enable=1 rtw_power_mgnt=1 rtw_switch_usb_mode=0 rtw_dfs_region_domain=1 rtw_wireless_mode=94
#
# After editing is complete, save this file (if using nano: Ctrl + x, y, Enter)
# and reboot to activate the changes.
#
# Documentation:
#
# -----
#
# Log options ( rtw_drv_log_level )
#
# 0 = NONE (default)
# 1 = ALWAYS
# 2 = ERROR
# 3 = WARNING
# 4 = INFO
# 5 = DEBUG
# 6 = MAX
#
# Note: You can save a log file that only includes RTW log entries by running
# the following in a terminal:
#
# sudo ./save-log.sh
#
# Note: The name of the log file will be rtw.log.
#
# -----
#
# LED options ( rtw_led_ctrl )
#
# 0 = Always off
# 1 = Normal blink (default)
# 2 = Always on
#
# -----
#
# VHT options ( rtw_vht_enable )
#
#  0 = Disable
#  1 = Enable (default)
#  2 = Force auto enable (use only for 5 GHz AP mode)
#
# Notes:
# - A non-default setting can degrade performance greatly in managed mode.
# - Option 2 allows 80 MHz channel width for 5GHz AP mode, such as when
#   you are using hostapd.
#
# -----
#
# Power options ( rtw_power_mgnt )
#
# 0 = Disable power saving
# 1 = Power saving on, minPS (default)
# 2 = Power saving on, maxPS (not recommended for AP mode)
#
# -----
#
# Beamforming options ( rtw_beamform_cap )
#
# 0 = Disable (default)
# 1 = SU Beamformer
# 2 = SU Beamformee
# 3 = SU Beamformer and SU Beamformee
# 10= SU Beamformee and MU Beamformee
# 11= SU Beamformer and SU Beamformee and MU Beamformee
#
# Note: MU Beamformer is not supported.
#
# -----
#
# Country Code options ( rtw_country_code )
#
# Note: Allows the Country Code to be set in cases where it is unable to
# be obtained from the operating system.
#
# Example for the US: rtw_country_code=US
# Example for Panama: rtw_country_code=PA
# Example for Norway: rtw_country_code=NO
# Example for Kuwait: rtw_country_code=KW
# Example for Taiwan: rtw_country_code=TW
# 
# -----
#
# DFS Options ( rtw_dfs_region_domain )
#
# 0 = NONE (default)
# 1 = FCC
# 2 = MKK
# 3 = ETSI
#
# Notes:
# - Activates DFS channels in AP mode.
# - DFS FCC 80 MHz channels for hostapd: 52(58), 100(106), 116(122) and 132(138)
# - For more information: https://en.wikipedia.org/wiki/List_of_WLAN_channels
#
# Note: An AP needs to listen on a DFS channel for a period of 60 seconds
# before transmitting on the channel. If any radar pulses are detected,
# the AP cannot use that channel and will have to try a different channel.
#
# -----
#
# Select P2P interface in concurrent mode ( rtw_sel_p2p_iface )
#
# 0 = Sets interface 0 to be p2p interface
# 1 = Sets interface 1 to be p2p interface (default) 
#
# -----
#
# Wireless Mode options ( rtw_wireless_mode )
#
# 1  = 2.4GHz 802.11b
# 2  = 2.4GHz 802.11g
# 3  = 2.4GHz 802.11b/g
# 4  = 5GHz 802.11a
# 8  = 2.4Hz 802.11n
# 11 = 2.4GHz 802.11b/g/n
# 16 = 5GHz 802.11n
# 20 = 5GHz 802.11a/n
# 64 = 5GHz 802.11ac
# 84 = 5GHz 802.11a/n/ac
# 95 = 2.4GHz 802.11b/g/n 5GHz 802.11a/n/ac (default)
#
# -----
#
# USB options ( rtw_switch_usb_mode )
#
# 0 = No switch (default)
# 1 = Switch from usb 2.0 to usb 3.0
# 2 = Switch from usb 3.0 to usb 2.0
#
# Note: This driver may need to stay in USB2 mode for AP mode operations
# on some platforms in order to avoid dropping offline. This issue has been
# observed on the Raspberry Pi 4B with both the 32 and 64 bit versions of the
# Raspberry Pi OS. This problem appears to be specific to the Raspberry Pi 4B
# and adapters based on the rtl8812bu chipset.
#    
# 
# -----
#
# To see all options that are available:
#
# $ ls /sys/module/88x2bu/parameters/
#
# -----
#
# To see the values that are in use:
#
# $ grep [[:alnum:]] /sys/module/88x2bu/parameters/*
#
# -----
#
# hostapd setup information for rtl88x2bu
# Note: The best settings can vary but the following may be a good place to start.
#
# /etc/modprobe.d/88x2bu.conf
# options 88x2bu rtw_drv_log_level=0 rtw_led_ctrl=0 rtw_vht_enable=2 rtw_power_mgnt=1 rtw_beamform_cap=0 rtw_dfs_region_domain=1 rtw_switch_usb_mode=1
#
# Note: The best setting for rtw_dfs_region_domain= will depend on your location.
#
# /etc/hostapd/hostapd.conf
#
# hw ht capab: 0x963
# ht_capab=[LDPC][HT40+][HT40-][SHORT-GI-20][SHORT-GI-40][MAX-AMSDU-7935]
#
# hw vht capab: 0x03c001a2
# vht_capab=[MAX-MPDU-11454][SHORT-GI-80][TX-STBC-2BY1][RX-STBC-1][HTC-VHT][MAX-A-MPDU-LEN-EXP7]
#
# -----
EOF' > /dev/null

sudo /bin/bash -c 'rm -f /etc/modprobe.d/rtw88_8822bu.conf; tee -a /etc/modprobe.d/rtw88_8822bu.conf <<EOF
blacklist rtw88_8822bu
EOF' > /dev/null
