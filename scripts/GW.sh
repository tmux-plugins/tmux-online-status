#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

online_option_string="@online_icon"
offline_option_string="@offline_icon"
ping_timeout_string="@ping_timeout"
route_to_ping_string="@route_to_ping"

online_icon_osx="✅ "

offline_icon_osx="⛔️ "
online_icon="#[fg=green]ok##[fg=white]"
offline_icon="#[fg=red]down##[fg=white]"
offline_icon_cygwin="X"
ping_timeout_default="3"

is_osx() {
	[ $(uname) == "Darwin" ]
}

is_cygwin() {
	[[ $(uname) =~ CYGWIN ]]
}

if is_osx; then 
    route_to_ping_default="$(ifconfig en0 | grep netmask | cut -d ' ' -f2)"
else
    route_to_ping_default="$(ip route | awk NR==1'{print $3}')"
fi

source $CURRENT_DIR/shared.sh


online_icon_default() {
	if is_osx; then
		echo "$online_icon_osx"
	else
		echo "$online_icon"
	fi
}

offline_icon_default() {
	if is_osx; then
		echo "$offline_icon_osx"
	elif is_cygwin; then
		echo "$offline_icon_cygwin"
	else
		echo "$offline_icon"
	fi
}

online_status() {
	if is_osx; then
		local timeout_flag="-t"
	else
		local timeout_flag="-w"
	fi
	if is_cygwin; then
		local number_pings_flag="-n"
	else
		local number_pings_flag="-c"
	fi
	local ping_timeout="$(get_tmux_option "$ping_timeout_string" "$ping_timeout_default")"
	local ping_route="$(get_tmux_option "$route_to_ping_string" "$route_to_ping_default")"
	ping "$number_pings_flag" 1 "$timeout_flag" "$ping_timeout" "$ping_route" >/dev/null 2>&1
}

print_icon() {
	if $(online_status); then
		printf "$(get_tmux_option "$online_option_string" "$(online_icon_default)")"
	else
		printf "$(get_tmux_option "$offline_option_string" "$(offline_icon_default)")"
	fi
}

main() {
	print_icon
}
main
