#!/bin/sh

# HELP: Update AXT or other components (see subcommands)
# USAGE: axt update <component>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

if (( $# == 1 )); then
	COMMAND="axt-update-${1}.sh"
	COMMAND_FILES=(`eval find ${AXT_PATH} -name ${COMMAND} -print`)
	if ((${#COMMAND_FILES[@]} == 1 )); then
		eval ${COMMAND_FILES[0]}
	else
		echo "AXT ERROR: sub command 'update ${1}' not found."
	fi
else
	eval ${AXT_PATH}/axt-update-axt.sh
fi
