#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

online_status_icon="#($CURRENT_DIR/scripts/online_status_icon.sh)"
online_status_interpolation_string="\#{online_status}"

source $CURRENT_DIR/scripts/shared.sh

do_interpolation() {
	local string="$1"
	local interpolated="${string/$online_status_interpolation_string/$online_status_icon}"
	echo "$interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	local interpolated_options="$(get_tmux_option "@plugin_interpolated_options" "status-right status-left")"
	for interpolated_option in $interpolated_options
	do
		update_tmux_option $interpolated_option
	done
}
main
