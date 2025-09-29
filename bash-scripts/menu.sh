#!/bin/bash

THEMES=("purple" "black-and-white" "green" "brown")
CHOICE=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu -p "Choose Theme")

if [ -n "$CHOICE" ]; then
    ~/bash-scripts/switcher.sh "$CHOICE"
fi
