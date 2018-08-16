#!/bin/sh

# HELP: AXT's HappyMake tools (use subcommands)
# USAGE: init | setup

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi


if (( $# >= 1 )); then
	COMMAND="axt-hm-${1}.sh"
	COMMAND_FILES=(`eval find ${AXT_PATH} -name ${COMMAND} -print`)
	if ((${#COMMAND_FILES[@]} == 1 )); then
		shift
		eval ${COMMAND_FILES[0]} $@
	else
		echo "AXT ERROR: sub command 'hm ${1}' not found."
	fi
else
	echo "AXT ERROR: command 'hm' needs a subcommand"
fi

