#!/usr/bin/env bash
killall wofi 2> /dev/null || hyprctl clients -j  | jq '.[] |  "(.address) (.class): (.title)"' -r  | wofi -c $HOME/.config/hypr/ui/wofi/config -s $HOME/.config/hypr/ui/wofi/style.css -d -i -W 699 -p "Switch to" | awk '{print "address:"$1}' | xargs hyprctl dispatch focuswindow
