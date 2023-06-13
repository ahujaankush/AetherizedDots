#!/usr/bin/env bash

CACHE_PATH="$HOME/.cache/eww/dunst/notifications.txt"
QUOTE_PATH="$HOME/.cache/eww/dunst/quotes.txt"
DEFAULT_QUOTE="\"To fake it is to stand guard over emptiness.\" ~ Arthur Herzog"

mkdir -p "${CACHE_PATH:h}" "${QUOTE_PATH:h}" 2> /dev/null
touch "$CACHE_PATH" "$QUOTE_PATH" 2> /dev/null

INTERVAL='0.5'

function rand_quote() {
  local format
  format="$(tr '\n \t\r' 's' < "$QUOTE_PATH")"
  if [[ "$format" != "" ]]; then
    shuf "$QUOTE_PATH" | head -n1 
  else
    echo "$DEFAULT_QUOTE"
  fi
}

function empty_format() {
  local format
  format=(
    "(box"
    ":class"
    "'disclose-empty-box'"
    ":height"
    "750"
    ":orientation"
    "'vertical'"
    ":space-evenly"
    "false"
    "(image"
    ":class"
    "'disclose-empty-banner'"
    ":valign"
    "'end'"
    ":vexpand"
    "true"
    ":path"
    "'./assets/wedding-bells.png'"
    ":image-width"
    "250"
    ":image-height"
    "250)"
    "(label"
    ":vexpand"
    "true"
    ":valign"
    "'start'"
    ":wrap"
    "true"
    ":class"
    "'disclose-empty-label'" 
    ":text"
    "'$(rand_quote)'))"
  )
  echo "${format[@]}"
}

function not_empty() {
  echo -n "(box :spacing 20 :orientation 'vertical' :space-evenly false"
  if [[ "$(echo "$1" | tr -d ' ')" != "" ]]; then
    echo -n "$1"
  else
    echo -n "$(empty_format)"
  fi
  echo ")"
}

case "$1" in
  rmid) sed -i "/:identity ':::###::::XXXWWW$2===::'/d" "$CACHE_PATH" ;;
  sub)
    $HYPR/ui/eww/src/shell/logger.py init 2> /dev/null &
    old="$(tr '\n' ' ' < "$CACHE_PATH")"
    not_empty "$old"
    while sleep "$INTERVAL"; do
      new="$(tr '\n' ' ' < "$CACHE_PATH")"
      if [[ "$old" != "$new" ]]; then
        not_empty "$new"
        old="$new"
      fi
    done
    ;;
  quote) rand_quote ;;
  cls) : > "$CACHE_PATH" ;;
esac

# vim:filetype=sh
