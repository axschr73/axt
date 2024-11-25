#!/bin/sh

# HELP: Remove trailing whitespaces from given folders
# USAGE:whitespaces <folder>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit 1
fi


if (( $# == 1 )); then
	python tools/checkbot/run_checkbot.py --path ${1} --check CheckTrailingWhitespaces --repair-changed-files
else
	echo >&2 "AXT ERROR: command 'whitespaces' need a folder"
	exit 1
fi
