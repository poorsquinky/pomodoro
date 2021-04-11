#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pomodoro_status="#($CURRENT_DIR/scripts/pomodoro.sh status)"
pomodoro_start="#($CURRENT_DIR/scripts/pomodoro.sh start)"
pomodoro_clear="#($CURRENT_DIR/scripts/pomodoro.sh clear)"

placeholder="\#{pomodoro_status}"

source $CURRENT_DIR/scripts/shared.sh
source $CURRENT_DIR/scripts/variables.sh

do_interpolation() {
	local string="$1"
	local interpolated="${string/$placeholder/$pomodoro_status}"
	echo "$interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

bind_tmux_key() {
    local key="$1"
    local command="$2"
    tmux bind-key "$key" run-shell "$command"
}

main() {
  update_tmux_option "status-left"
  update_tmux_option "status-right"
  bind_tmux_key "$start_key" "$pomodoro_start"
  bind_tmux_key "$clear_key" "$pomodoro_clear"
}

main
