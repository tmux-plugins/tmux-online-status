#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

online_option_string="@online_icon"
offline_option_string="@offline_icon"
ping_timeout_string="@ping_timeout"
route_to_ping_string="@route_to_ping"

online_icon_osx="✅ "
online_icon="✔ "
offline_icon_osx="⛔️ "
offline_icon="❌ "
ping_timeout_default="10"
route_to_ping_default="www.google.com"

source $CURRENT_DIR/shared.sh

is_osx() {
	[ $(uname) == "Darwin" ]
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
	else
		echo "$offline_icon"
	fi
}

online_status() {
	if is_osx; then
		timeout_flag="-t"
	else
		timeout_flag="-w"
	fi
	ping -c 1 \
		$timeout_flag \
		$(get_tmux_option "$ping_timeout_string" "$ping_timeout_default") \
		$(get_tmux_option "$route_to_ping_string" "$route_to_ping_default") \
		>/dev/null 2>&1
}

print_icon() {
	# spacer fixes weird emoji spacing
	local spacer=" "
	if $(online_status); then
		printf "$(get_tmux_option "$online_option_string" "$(online_icon_default)")$spacer"
	else
		printf "$(get_tmux_option "$offline_option_string" "$(offline_icon_default)")$spacer"
	fi
}

main() {
	print_icon "$status"
}
main
