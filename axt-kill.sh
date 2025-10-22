#!/bin/sh

# HELP: Kill processess with given string in command line
# USAGE: axt kill <string>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


if (( $# == 1 )); then
	pkill -9 -f $1
elif (( $# == 0 )); then
	echo >&2 "AXT ERROR: command 'axt kill' needs a string."
	exit 1
else
	echo >&2 "AXT ERROR: command 'axt kill' needs cannot handle more than one argument."
	exit 1
fi

