#!/bin/sh

# HELP: Create new tmux sessions
# USAGE: axt tmux new <session_name>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


if (( $# == 1 )); then
	tmux new-session -s $1
else
	echo >&2 "AXT ERROR: command 'tmux new' needs a session name"
	exit 1
fi

