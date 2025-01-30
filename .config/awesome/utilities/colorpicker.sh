#!/bin/bash

# Pick color using gpick and save the color code
COLOR=$(gpick --no-newline -pso)
TMP="/tmp/colorpicker.png"

# Check if dependencies are installed and handle errors
if ! command -v gpick &>/dev/null; then
    notify-send -u critical -a "Color Picker" "Color Picker" "gpick needs to be installed"
    exit 1
fi

if ! command -v magick &>/dev/null; then
    notify-send -u critical -a "Color Picker" "Color Picker" "imagemagick needs to be installed"
    exit 1
fi

# Create a 120x120 pixel image with the selected color
magick -size 120x120 xc:"$COLOR" "$TMP"

# Copy the color code to clipboard
printf "%s" "$COLOR" | xclip -selection clipboard

# Send a notification with the color and image
notify-send -a "Color Picker" -i "$TMP" "Color Picker" "$COLOR"
