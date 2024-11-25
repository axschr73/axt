#!/bin/sh

# HELP: axt git diff

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


MODE=""

while [[ "$1" == "--"* ]]; do
	case $1 in
		--blame)	MODE="${MODE}blame"	;;
		*)			echo "AXT ERROR: Unknown mode $1"
					exit 1
					;;
	esac
	shift
done


if [[ "$MODE" == "blame" ]]; then
	echo "NOT IMPLEMENTED"
	exit 1
else
	git --no-pager diff $1 $2
fi
