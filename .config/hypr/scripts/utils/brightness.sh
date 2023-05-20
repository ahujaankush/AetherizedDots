#!/usr/bin/env bash
# Brightness handler using brightnessctl
ICONDIR=$HOME/.config/hypr/ui/icons/aether/dark

function cbright {
  light | awk '{print int($1+0.5)}'
}

function notify {

  $SCRIPTS/apps/eww.sh update brightness-level=$(brightnessctl i -m | tr , " " | awk '{print $4}' | cut -c 1-2)
  $SCRIPTS/apps/eww.sh open brightness-indicator
  open=$($SCRIPTS/apps/eww.sh get brightnessreveal)
  echo $open
  if $open ; then
    kill $(pgrep -f "notifbrisleep")
    kill $(pgrep -f "notifbrianimsleep")
    (exec -a "notifbrisleep" sleep 3s) && $SCRIPTS/apps/eww.sh update brightnessreveal=false && (exec -a "notifbrianimsleep" sleep 1.55s) && $SCRIPTS/apps/eww.sh close brightness-indicator
  else
    $SCRIPTS/apps/eww.sh update brightnessreveal=true
    (exec -a "notifbrianimsleep" sleep 0.55s) 
    (exec -a "notifbrisleep" sleep 3s) 
    notify
  fi
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
