#!/bin/sh
xwallpaper --zoom /home/dillon/wallpaper.jpg
xrandr --output Virtual-1 --mode 1440x900
autostart="xcompmgr pipewire"
for program in $autostart; do
        pidof -s "$program" || setsid -f "$program"
done >/dev/null 2>&1
exec i3 
