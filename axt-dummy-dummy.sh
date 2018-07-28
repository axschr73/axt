#/bin/bash

# HELP: dummy subcommand

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

# find all axt-*.sh files
AXT_FILES=(`find ${AXT_PATH} -name 'axt-*.sh' -print`)

if [[ ${AXT_FILES} ]]; then
	# get all subcommands
	SUBCOMMANDS=()
	for AXT_FILE in "${AXT_FILES[@]}"
	do :
		if [[ ! ${AXTFILE} =~ .*/axt-.*-.*sh ]]; then
			echo "axt: ${AXT_FILE}"
		fi
	done
else
	echo "No AXT suubcommands found."
fi

#exec grep '# HELP: ' {} + | grep -v AXT_PATH l


