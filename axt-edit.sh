#!/bin/sh

# HELP: Edit an existing AXT command or file (see subcommands)
# USAGE: axt edit command|file

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

if (( $# == 1 )); then
	COMMAND="axt-${1}.sh"
	COMMAND_FILES=(`eval find ${AXT_PATH} -name ${COMMAND} -print`)
	if ((${#COMMAND_FILES[@]} == 1 )); then
		eval ${AXT_EDITOR} ${COMMAND_FILES[0]}
	else
 		COMMAND="axt-edit-${1}.sh"
		COMMAND_FILES=(`eval find ${AXT_PATH} -name ${COMMAND} -print`)
		if ((${#COMMAND_FILES[@]} == 1 )); then
			eval ${COMMAND_FILES[0]}
		else
			echo "AXT ERROR: command 'edit ${1}' not found."
		fi
	fi
else
	echo "AXT ERROR: edit needs an argument"
fi
