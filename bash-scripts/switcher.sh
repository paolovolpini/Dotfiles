#!/bin/sh
if [ $# != 1 ]; then
	echo "Pass theme name as argument"
	exit 1
fi

WALLPAPER=""
KITTY_THEME=""
NVIM_THEME=""
SPICETIFY_THEME=""
SPICETIFY_COLOR=""
#if [ "$1" = "nord" ]; then
#	echo "Nord theme selected"

if [ "$1" = "purple" ]; then
	echo "Purple theme selected"
	WALLPAPER="flowers.png"
	KITTY_THEME="dracula"
	NVIM_THEME="dracula"
	SPICETIFY_THEME="Sleek"
	SPICETIFY_COLOR="dracula"

elif [ "$1" = "black-and-white" ]; then
	echo "Black and white theme selected"
	WALLPAPER="black-and-white.png"
	KITTY_THEME="carbonfox"
	NVIM_THEME="carbonfox"
	SPICETIFY_THEME="Blackout"
	SPICETIFY_COLOR="def"

elif [ "$1" = "green" ]; then
	echo "Green theme selected"
	WALLPAPER="green.jpg"
	KITTY_THEME="Everforest Dark Hard"
	NVIM_THEME="everforest"
	SPICETIFY_THEME="Dribbblish"
	SPICETIFY_COLOR="gruvbox"
	
elif [ "$1" = "brown" ]; then
	echo "Brown theme selected"
	WALLPAPER="brown.jpg"
	KITTY_THEME="Gruvbox Dark"
	NVIM_THEME="gruvbox"
	SPICETIFY_THEME="BurntSienna"
	SPICETIFY_COLOR="def"

else
	echo "Theme not recognized"
	exit 2

fi

if  ! pgrep -x "hyprpaper" > /dev/null ; then
	/usr/bin/hyprpaper > /dev/null &
fi

rm /home/pablo/Immagini/wallpaper
ln -s /home/pablo/Immagini/Wallpapers/"$WALLPAPER" /home/pablo/Immagini/wallpaper

hyprctl hyprpaper reload ,/home/pablo/Immagini/wallpaper

# source colors, export variables for envsubst
. /home/pablo/.config/colors/"$1".conf
export FRAME_COLOR FG_LOW BG_LOW FG_NORMAL BG_NORMAL FG_CRITICAL BG_CRITICAL TOP_LEFT_HYPR BOT_RIGHT_HYPR WAYBAR_WSBUT_ACTIVE WAYBAR_WSBUT_HOVER WAYBAR_BLSLIDER_BG WAYBAR_BLUETOOTH WAYBAR_CPU WAYBAR_MEMORY WAYBAR_TEMP WAYBAR_BAT_CHRG WAYBAR_BAT_PLUG WAYBAR_BAT_WARN WAYBAR_BAT_CRIT WAYBAR_PPD_PERF WAYBAR_PPD_BAL WAYBAR_PPD_SAVE WAYBAR_VOLUME WAYBAR_POWER ROFI_BG ROFI_ACTIVEBG ROFI_URGENTBG ROFI_URGENTFG CONF_GTK_THEME CONF_ICON_THEME 
echo selected "$1".conf
# modify dunst configuration
envsubst < /home/pablo/.config/dunst/dunstrc.template > /home/pablo/.config/dunst/dunstrc
killall dunst && dunst 2>&1 > /dev/null &

# load colors of borders in window
ln -sf /home/pablo/.config/hypr/themes/"$1".conf /home/pablo/.config/hypr/hyprland.conf
hyprctl reload
export GTK_THEME=$CONF_GTK_THEME
gsettings set org.gnome.desktop.interface gtk-theme $CONF_GTK_THEME
killall nautilus 
 

# change colors in kitty

kitten themes --reload-in=all $KITTY_THEME

# change nvim theme

ln -sf /home/pablo/.config/nvim/lua/config/"$NVIM_THEME"-scheme.lua /home/pablo/.config/nvim/lua/config/colorscheme.lua

# change waybar style.css and config.jsonc
envsubst < /home/pablo/.config/waybar/style.template.css > /home/pablo/.config/waybar/style.css
envsubst < /home/pablo/.config/waybar/config.template.jsonc > /home/pablo/.config/waybar/config.jsonc
killall waybar && waybar > /dev/null 2>&1 &

# change rofi config.rasi
envsubst < /home/pablo/.config/rofi/config.template.rasi > /home/pablo/.config/rofi/config.rasi

# change gtk theme
envsubst < /home/pablo/.config/gtk-3.0/settings.template.ini > /home/pablo/.config/gtk-3.0/settings.ini
envsubst < /home/pablo/.config/gtk-4.0/settings.template.ini > /home/pablo/.config/gtk-4.0/settings.ini

# change spotify theme with spicetify
spicetify config current_theme $SPICETIFY_THEME color_scheme $SPICETIFY_COLOR
spicetify apply
