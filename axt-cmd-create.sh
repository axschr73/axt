#!/bin/sh

# HELP: Create a new AXT command
# USAGE: axt create [directory/] command

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
test -v AXT_EDITOR || { echo >&2 "AXT ERROR: \$AXT_EDITOR not set, run 'axt setup'"; exit 1; }


if (( $# == 1 )); then
	COMMAND_PATH="${AXT_PATH}"
	COMMAND="$1"
	if [[ $COMMAND =~ .*/.* ]]; then
		COMMAND_PATH="${COMMAND_PATH}/${COMMAND%%/*}"
		COMMAND="${COMMAND##*/}"
	fi

	FULLNAME="${COMMAND_PATH}/axt-${COMMAND}.sh"

	if [ ! -f ${FULLNAME} ]; then
		if [ ! -d ${COMMAND_PATH} ]; then
			mkdir ${COMMAND_PATH}
		fi

		cp ${AXT_PATH}/axt-template ${FULLNAME}
		chmod +x ${FULLNAME}

		eval "${AXT_EDITOR} ${FULLNAME}"
	else
		echo >&2 "AXT ERROR: command ${1} already exists"
		exit 1
	fi
else
	echo >&2 "AXT ERROR: You need to enter a name for the AXT command you want to create."
	exit 1
fi
