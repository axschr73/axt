#!/bin/sh

# HELP: Kill tmux session
# USAGE: axt tmux kill [session_name] (no parameter = choose running session)

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
command -v peco  >/dev/null 2>&1 || { echo >&2 "AXT ERROR: axt tmux requires helper 'peco'!"; exit 1; }


if (( $# == 0 )); then
	SESSIONNAME=$(tmux list-sessions -F "#{session_name}" | peco)
	tmux kill-session -t ${SESSIONNAME}
elif (( $# == 1 )); then
	tmux kill-session -t ${1}
else
	echo >&2 "AXT ERROR: command 'axt tmux kill' can have at most one parameter"
	exit 1
fi
