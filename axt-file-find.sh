#!/bin/sh

# HELP: Find a file by name or pattern in current directory (recursive)
# USAGE: axt find <pattern>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


if (( $# == 1 )); then
	find . -name $1 -print
elif (( $# == 2 )); then
	find $1 -name $2 -print
elif (( $# == 0 )); then
	echo >&2 "AXT ERROR: Command 'find' needs a search pattern (and optional start directory)."
	exit 1
else
	echo >&2 "AXT ERROR: Command 'find' takes at most a start directory and a search pattern."
	exit 1
fi
