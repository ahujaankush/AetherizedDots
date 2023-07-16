#!/usr/bin/env bash

function launch() {
  local running
  running="$(pgrep -x "$1")"
  [ "$running" ] && kill "$running" 2> /dev/null
  eval "$* &>/dev/null &"
  echo -e "$(tput setf 1)INFO\e[0m: Restarted $1."
}

# Wallpaper
launch "swww init && $SCRIPTS/utils/wallpaper.sh $HYPR/Wallpaper.png &"
# Polkit
launch /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# Waybar
launch waybar -c $HYPR/ui/waybar/config -s $HYPR/ui/waybar/style.css &
# Notification Daemon
launch dunst -config $HYPR/ui/dunst/dunstrc &
: > $HOME/.cache/dunst/battery.txt &
# Clipboard
launch wl-paste --type text --watch cliphist store & #Stores only text data
launch wl-paste --type image --watch cliphist store & #Stores only image data
# Applets
launch nm-applet --indicator &

launch "$SCRIPTS/apps/eww.sh open origin && $SCRIPTS/apps/eww.sh open melody && $SCRIPTS/apps/eww.sh open lumin && $SCRIPTS/apps/eww.sh open disclose && $SCRIPTS/apps/eww.sh open chrono"
