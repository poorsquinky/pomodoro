#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/shared.sh"

# default_start_key="a"
# start_key=$(tmux show-option -gqv "@pomodoro_start_key")
# start_key=${start_key:-$default_start_key}
start_key=$(get_tmux_option "@pomodoro_start_key" "a")

# default_clear_key="A"
# clear_key=$(tmux show-option -gqv "@pomodoro_clear_key")
# clear_key=${start_key:-$default_clear_key}
clear_key=$(get_tmux_option "@pomodoro_clear_key" "A")
