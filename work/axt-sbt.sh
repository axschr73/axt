#!/bin/sh

# HELP: Execute tests registered with the Basis::TestFrame framework
# USAGE: all | basis | pers

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi


if (( $# >= 1 )); then
	COMMAND="axt-sbt-${1}.sh"
	COMMAND_FILES=(`eval find ${AXT_PATH} -name ${COMMAND} -print`)
	if ((${#COMMAND_FILES[@]} == 1 )); then
		shift
		eval ${COMMAND_FILES[0]} $@
	else
		echo "AXT ERROR: sub command 'sbt ${1}' not found."
	fi
else
	echo "AXT ERROR: command 'sbt' needs a subcommand"
fi