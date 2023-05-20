#!/usr/bin/env bash

# Audio volume changer using pamixer
function cvol {
  pamixer --get-volume
}

function chkmute {
  pamixer --get-mute
}

function notify {
  $SCRIPTS/apps/eww.sh update volume-level=`cvol`
  $SCRIPTS/apps/eww.sh update volume-muted=`chkmute`
  $SCRIPTS/apps/eww.sh open volume-indicator
  open=$($SCRIPTS/apps/eww.sh get volumereveal)
  echo $open
  if $open ; then
    kill $(pgrep -f "notifvolsleep")
    kill $(pgrep -f "notifvolanimsleep")
    (exec -a "notifvolsleep" sleep 3s) && $SCRIPTS/apps/eww.sh update volumereveal=false && (exec -a "notifvolanimsleep" sleep 0.55s) && $SCRIPTS/apps/eww.sh close volume-indicator
  else
    $SCRIPTS/apps/eww.sh update volumereveal=true
    (exec -a "notifvolanimsleep" sleep 0.55s) 
    (exec -a "notifvolsleep" sleep 3s) 
    notify
  fi
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
	  notify
	;;
esac     
