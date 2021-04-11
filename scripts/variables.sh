#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/shared.sh"

POMODORO_START_KEY=$(get_tmux_option "@pomodoro_start_key" "a")
POMODORO_CLEAR_KEY=$(get_tmux_option "@pomodoro_clear_key" "A")

POMODORO_STATUS_FILE=$(get_tmux_option  "@pomodoro_status_file" "/tmp/pom_$USER")
POMODORO_BANG=$(get_tmux_option "@pomodoro_bang" "❗")
POMODORO_SYMBOL=$(get_tmux_option "@pomodoro_symbol" "🍅")
POMODORO_NBSP=$(get_tmux_option "@pomodoro_nbsp" " ")
POMODORO_MINUTES=$(get_tmux_option "@pomodoro_minutes" 25)

POMODORO_GRAPH_BLOCKS=$(get_tmux_option "@pomodoro_graph_blocks" "( ▁ ▂ ▃ ▄ ▅ ▆ ▇ )")
POMODORO_DOT_BLOCKS=$(get_tmux_option "@pomodoro_dot_blocks" "( ⠈ ⠨ ⠩ ⠭ )")
POMODORO_GRAPHICAL=$(get_tmux_option "@pomodoro_graphical" 0)
POMODORO_DATA_ONLY=$(get_tmux_option "@pomodoro_data_only" 0)

POMODORO_SSH=$(get_tmux_option "@pomodoro_ssh" "")
POMODORO_REMOTE_CMD=$(get_tmux_option "@pomodoro_remote_cmd" "")

POMODORO_HOOK=$(get_tmux_option "@pomodoro_hook" "")
