#!/bin/sh

/usr/bin/hyprpaper &
sleep 2
while true
do
	BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status | tr -d '\n')
	echo $BATTERY_STATUS
	if [ "$BATTERY_STATUS" = "Discharging" ]
	then
		echo "Killing mpvpaper..."
		pkill -f mpvpaper
		
	else
		if ! pgrep -x mpvpaper > /dev/null
		then
			echo "Starting mpvpaper..."
			/usr/bin/mpvpaper --fork -p -o "no-audio loop framedrop=va" ALL /home/pablo/Immagini/Wallpapers/flowers.mp4
			
		fi
	fi
	sleep 5
done
