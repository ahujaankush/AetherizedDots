#!/usr/bin/env bash

file=$HOME/.cache/dunst/battery.txt
mkdir -p $HOME/.cache/dunst/
if [ ! -e $file ] ; then
  touch $file
fi

bat=$(cat /sys/class/power_supply/BAT*/capacity)
plugged=$(cat /sys/class/power_supply/ADP1/online)
low=20
medium=70

low_icon=$HYPR/ui/dunst/icons/notifications/battery/battery_low.png
medium_icon=$HYPR/ui/dunst/icons/notifications/battery/battery_medium.png
charging_icon=$HYPR/ui/dunst/icons/notifications/battery/battery_charging.png

if (( $plugged == 0 )); then
  echo "Running on battery"
  if (( $bat <= $low )); then
    echo "Battery low"
    if ! grep -q "lowNotif true" $file; then
      echo "Notify low"
      notify-send "Battery" "Low" -i $low_icon -u critical -a battery_low
    fi
    echo "medNotif false" > $file 
    echo "lowNotif true" >> $file
  elif (( $bat <= $medium )); then
    echo "Battery medium"
    if ! grep -q "medNotif true" "$file"; then
      echo "Notify medium"
      notify-send "Battery" "Medium" -i $medium_icon -u critical -a battery_medium 
    fi
    echo "lowNotif false" > $file
    echo "medNotif true" >> $file
  else
    echo "lowNotif false" > $file
    echo "medNotif false" >> $file
  fi
  echo "plugNotif false" >> $file
elif ! grep -q "plugNotif true" $file; then
  notify-send "Charger" "Plugged" -i $charging_icon -u critical -a charger_plugged
  echo "lowNotif false" > $file
  echo "medNotif false" >> $file
  echo "plugNotif true" >> $file
fi
