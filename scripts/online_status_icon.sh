#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

online_option_string="@online_icon"
offline_option_string="@offline_icon"
ping_timeout_string="@ping_timeout"
route_to_ping_string="@route_to_ping"

online_icon_osx="✅ "
online_icon="✔"
offline_icon_osx="⛔️ "
offline_icon_cygwin="X"
offline_icon="❌ "
ping_timeout_default="3"
route_to_ping_default="www.google.com"

source $CURRENT_DIR/shared.sh

is_osx() {
	[ $(uname) == "Darwin" ]
}

is_cygwin() {
	[[ $(uname) =~ CYGWIN ]]
}

is_freebsd() {
	[ $(uname) == FreeBSD ]
}

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
	if is_osx || is_freebsd; then
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
