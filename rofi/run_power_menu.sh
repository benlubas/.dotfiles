#!/usr/bin/env bash

# based on: https://github.com/adi1090x/rofi/blob/master/files/powermenu/type-3/powermenu.sh 

theme="$HOME/.config/rofi/power_menu.rasi"

uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

lock='  Lock'
logout='  Logout'
shutdown='  Shutdown'
reboot="  Restart"

rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$logout\n$shutdown\n$reboot" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
    systemctl poweroff
        ;;
    $reboot)
    systemctl reboot
        ;;
    $lock)
    $HOME/.config/i3/lock.sh
        ;;
    $logout)
    i3-msg exit
        ;;
esac
