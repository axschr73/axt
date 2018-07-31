#!/bin/sh

# HELP: Create a new AXT command
# USAGE: axt create [directory/] command

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

if (( $# == 1 )); then
	COMMAND_PATH="${AXT_PATH}"
	COMMAND=$1
	if [[ $COMMAND =~ .*/.* ]]; then
		COMMAND_PATH="${COMMAND_PATH}/${COMMAND%%/*}"
		COMMAND="${COMMAND##*/}"
	fi

	FULLNAME="${COMMAND_PATH}/axt-${COMMAND}.sh" 

	if [ ! -f ${FULLNAME} ]; then
		if [ ! -d ${COMMAND_PATH} ]; then
			mkdir ${COMMAND_PATH}
		fi

		cp ${AXT_PATH}/axt-template.txt ${FULLNAME}
		chmod +x ${FULLNAME}

		eval "${AXT_EDITOR} ${FULLNAME}"
	else
		echo "AXT ERROR: command ${1} already exists"
	fi
else
	echo "AXT ERROR: You need to enter a name for the AXT command you want to create."
fi
