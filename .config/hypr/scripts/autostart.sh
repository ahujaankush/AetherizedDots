#!/usr/bin/env bash
HYPR="$HOME/.config/hypr"
SCRIPTS="$HYPR/scripts"

# Wallpaper

swww init && $SCRIPTS/utils/wallpaper.sh $HYPR/Wallpaper &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# Waybar
HYPR="$HOME/.config/hypr" && waybar -c $HYPR/ui/waybar/dock -s $HYPR/ui/waybar/style.css & waybar -c $HYPR/ui/waybar/config -s $HYPR/ui/waybar/style.css &
# Notification Daemon
dunst -config $HYPR/ui/dunst/dunstrc &
# EWW Daemon
$SCRIPTS/apps/eww.sh daemon &
# Applets
nm-applet --indicator &
