#!/bin/bash
set -e

mkdir -p ~/.steam/root/skins
cd ~/.steam/root/skins
mkdir -p StopAnimations/resource
cp -r ~/.steam/root/resource/styles StopAnimations/resource
sed -i '/Notifications.SlideDirection/ s/"[A-Za-z]*"/"None"/' StopAnimations/resource/styles/* #no animation sliding
sed -i '/Notifications.FadeInTime/ s/"0.[0-9+]*"/"0.0"/' StopAnimations/resource/styles/* #no fade in time for notifications
sed -i '/Notifications.FadeOutTime/ s/"0.[0-9+]*"/"0.0"/' StopAnimations/resource/styles/* #no fade out time for notifications
sed -i '/Notifications.StackSize/ s/"[0-9]*"/"5"/' StopAnimations/resource/styles/* #show max 5 notifications instead of max 3 at the same time
cd $script_dir
