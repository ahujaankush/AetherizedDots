#!/usr/bin/env bash

# Wallpaper
swww init && $SCRIPTS/utils/wallpaper.sh $HYPR/Wallpaper &
# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# Waybar
waybar -c $HYPR/ui/waybar/dock -s $HYPR/ui/waybar/style.css & waybar -c $HYPR/ui/waybar/config -s $HYPR/ui/waybar/style.css &
# Notification Daemon
dunst -config $HYPR/ui/dunst/dunstrc &
# Clipboard
wl-paste --type text --watch cliphist store & #Stores only text data
wl-paste --type image --watch cliphist store & #Stores only image data
# EWW Daemon
$SCRIPTS/apps/eww.sh daemon &
# Applets
nm-applet --indicator &
