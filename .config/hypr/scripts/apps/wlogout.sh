#!/usr/bin/env bash
killall wlogout 2> /dev/null || wlogout --css $HOME/.config/hypr/ui/wlogout/style.css --layout $HOME/.config/hypr/ui/wlogout/layout -b 5 -T 500 -B 500
