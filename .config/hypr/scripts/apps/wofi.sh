#!/usr/bin/env bash
killall wofi 2> /dev/null || wofi -c $HOME/.config/hypr/ui/wofi/config -s $HOME/.config/hypr/ui/wofi/style.css
