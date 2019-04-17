#!/bin/bash
# aa.sh - aa and voilá! Status line.
#
#
# Requires: acpi, nmcli, amixer, awk, sed
#
# Author  : Rahul Martim Juliato (rahul.juliato@gmail.com)
#
# Version 1   -  01.09.2017 - Initial Release
# Version 2   -  12.11.2018 - Setup for gallium
#
#
#
# >>>>> Adjust to your personal setup. <<<<<
#
# Output example: [C:My_wifi] [L:0.60] [D:57%] [M:150M] [S:Mute] [B:50%] [01.09.2017 15:07]


#Variables
MESSAGE="
Usage: $(basename "$0") [option]

[options]
--help		Shows this message
--version	Shows current version
"


#Processing options
case "$1" in 
	--help)
	    	echo "$MESSAGE"
	    	exit 0
	    	;;

	--version)
		echo 
		sed -n "2p" "$0" | tr -d "#"
		echo
		grep -e "^# Aut" "$0" | cut -d ":" -f 2 | tr -d "#"
		grep -e "^# Ver" "$0" | tail -n 1 | cut -d "-" -f 1,2 | tr -d "#"
		echo
		exit 0
		;;
esac

	 
#Gets all info
BATT=$( acpi | cut -d ',' -f 2 | tr -d ',' | tr -d " " )
CONN=$( nmcli con show --active | tail -n 1 | cut -d " " -f1 | cut -c 1-8 )
VOLU=$( [ `amixer sget "Speaker Channel" 2> /dev/null | awk -F"[][]" '{ print $2 }' | uniq | grep o ` = "off" ] && echo "Mute" || echo `amixer sget "Speaker" 2> /dev/null | awk -F"[][]" '{ print $2 }' | uniq | grep %` )
USAG=$( df | grep /dev/mmcblk | cut -d "%" -f1 | grep -o '[^" "]\+$' )%
MEMO=$( free -h | cut -d ' ' -f20-22 | tr -d ' ' | grep -e "^[1-9].*" )
LOAD=$( uptime | cut -d "," -f3-4 | cut -d ":" -f2 | cut -d "," -f    1-3 | tr ',' '.' | tr -d " " )
DATE=$( date +%d.%m.%Y\ %H:%M )


#Format and display info
echo [C:$CONN] [L:$LOAD] [D:$USAG] [M:$MEMO] [S:$VOLU] [B:$BATT] [$DATE]
