#!/usr/bin/env bash
# Brightness handler using brightnessctl
ICONDIR=$HOME/.config/hypr/ui/icons/aether/dark

function cbright {
  light | awk '{print int($1+0.5)}'
}

function notify {
    brightness=`cbright`
    
    if [ "$brightness" = "0" ]; then
        icon_name="$ICONDIR/brightness-off"
    else    
        if [  "$brightness" -lt "10" ]; then
            icon_name="$ICONDIR/brightness-low"
        else
            if [ "$brightness" -lt "25" ]; then
                icon_name="$ICONDIR/brightness-low"
            else
                if [ "$brightness" -lt "50" ]; then
                    icon_name="$ICONDIR/brightness-medium"
                else
                    if [ "$brightness" -lt "75" ]; then
                        icon_name="$ICONDIR/brightness-high"
                    else
                        icon_name="$ICONDIR/brightness-full"
                    fi
                fi
            fi
        fi
    fi
    notify-send -i "$icon_name.png" -t 2000 -r 1234 "$brightness" "Brightness"
}

case $1 in
    up)
	light -A 5
	notify
	;;
    down)
  light -U 5
	notify
	;;
    optimal)
    # Toggle optimal
	  light -S 50
    notify
	;;
esac     
