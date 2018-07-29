#/bin/bash

# setup environment
cd $(dirname $0)
export AXT_PATH=$(pwd)

source ${AXT_PATH}/.axtrc


# process subcommand
SUBCOMMAND=$1
shift

if [[ -z $SUBCOMMAND ]]; then
    SUBCOMMAND="help"
fi


# execute full command
COMMAND="axt-${SUBCOMMAND}.sh"
FULL_COMMAND=$(find ${AXTPATH} -name ${COMMAND} -print)

if [[ ${FULL_COMMAND} ]]; then
	eval "${FULL_COMMAND} $@"
else
	echo "axt: Unknown command '${SUBCOMMAND}'"
fi

