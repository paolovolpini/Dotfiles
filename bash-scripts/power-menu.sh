#!/bin/sh
chosen=$(echo -e "⏻ Shutdown\n Reboot\n Suspend\n Lock" | rofi -dmenu -p "Power Menu")

case "$chosen" in
  "⏻ Shutdown") systemctl poweroff ;;
  " Reboot") systemctl reboot ;;
  " Suspend") systemctl suspend; hyprlock ;;
  " Lock") hyprlock ;; 
esac
