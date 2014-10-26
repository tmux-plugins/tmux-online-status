#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

online_option_string="@online_icon"
offline_option_string="@offline_icon"
route_to_ping_string="@route_to_ping"

online_icon_osx="✅ "
online_icon="✔ "
offline_icon_osx="⛔️ "
offline_icon="❌ "

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

route_to_ping_default() {
  echo "www.google.com"
}

online_status() {
	ping -c 3 $(get_tmux_option "$route_to_ping_string" "$(route_to_ping_default)" >/dev/null 2>&1
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
