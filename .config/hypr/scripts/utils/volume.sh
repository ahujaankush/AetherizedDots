#!/usr/bin/env bash

# Audio volume changer using pamixer
ICONDIR=$HOME/.config/hypr/ui/icons/aether/dark
function cvol {
  pamixer --get-volume
}

function chkmute {
  pamixer --get-mute | grep "true"
}

function notify {
    volume=`cvol`
    
    if [ "$volume" = "0" ]; then
        icon_name="$ICONDIR/volume-muted"
    else    
        if [  "$volume" -lt "33" ]; then
            icon_name="$ICONDIR/volume-low"
        else
          if [ "$volume" -lt "66" ]; then
            icon_name="$ICONDIR/volume-medium"
          else
            icon_name="$ICONDIR/volume-high"
          fi
        fi
    fi

    notify-send -i "$icon_name.png" -t 2000 -r 123 "$volume" "Volume"
}

case $1 in
    up)
	# +5%
	pamixer -i 5
	notify
	;;
    down)
    # -5%
	pamixer -d 5
	notify
	;;
    mute)
    # Toggle mute
	pamixer -t
	if chkmute; then
    icon_name="$ICONDIR/volume-muted"
    notify-send -i "$icon_name.png" -t 2000 -r 123 "Muted" "Volume"
	else
	  notify
	fi
	;;
esac     
