#!/bin/sh

# HELP: Manage tmux sessions
# USAGE: axt tmux [new | kill | session_name] (no parameter = choose session to attach to)

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
command -v peco  >/dev/null 2>&1 || { echo >&2 "AXT ERROR: axt tmux requires helper 'peco'!"; exit 1; }


if (( $# == 0 )); then
	SESSION=$(tmux list-sessions -F "#{session_name}" | peco)
	tmux attach-session -t ${SESSION}
else
	echo >&2 "AXT ERROR: command 'axt tmux' does not take arguments."
	exit 1
fi

