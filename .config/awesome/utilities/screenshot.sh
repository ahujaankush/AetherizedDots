#!/bin/bash

APP_NAME="Screenshot"
TARGET_DIR="$HOME/Pictures/Screenshots"
TARGET_FILE="$TARGET_DIR/$(date +%Y%m%d_%H%M%S).png"
NOTIF_MESSAGE="A screenshot has been taken!"

send_error_notification() {
    awesome-client "
        naughty = require('naughty')
        naughty.notification({
            app_name = '${APP_NAME}',
            title = 'Screenshot Failed!',
            message = 'There was an error while taking the screenshot.',
            timeout = 10,
            urgency = 'critical'
        })
    "
}

# Check if the target directory exists, if not, create it
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

# Parse command-line arguments
fullscreen=false
while getopts "f" opt; do
  case $opt in
    f)
      fullscreen=true
      ;;
    *)
      echo "Usage: $0 [-f]"
      exit 1
      ;;
  esac
done

# Decide on the screenshot type
if $fullscreen; then
    maim -u "$TARGET_FILE"
else
    maim -c 1,1,1 -u -b 3 -m 5 -s "$TARGET_FILE"
fi

# Check if maim succeeded
if [[ $? -eq 0 ]]; then
    awesome-client "
        naughty = require('naughty')
        awful = require('awful')
        beautiful = require('beautiful')

        local open_image = naughty.action {
            name = 'Open',
            icon_only = false,
        }

        local delete_image = naughty.action {
            name = 'Delete',
            icon_only = false,
        }

        local copy_to_clipboard = naughty.action {
            name = 'Copy',
            icon_only = false,
        }

        -- Execute the callback when 'Open' is pressed
        open_image:connect_signal('invoked', function()
            awful.spawn('xdg-open ${TARGET_FILE}', false)
        end)

        -- Execute the callback when 'Delete' is pressed
        delete_image:connect_signal('invoked', function()
            awful.spawn('gio trash ${TARGET_FILE}', false)
        end)

        -- Execute the callback when 'Copy to Clipboard' is pressed
        copy_to_clipboard:connect_signal('invoked', function()
            awful.spawn('xclip -selection clipboard -t image/png -i ${TARGET_FILE}', false)
        end)

        naughty.notification({
            app_name = '${APP_NAME}',
            icon = '${TARGET_FILE}',
            timeout = 10,
            title = 'Screenshot!',
            message = '${NOTIF_MESSAGE}',
            actions = { copy_to_clipboard, open_image, delete_image}
        })
    "
else
    send_error_notification
    exit 1
fi

