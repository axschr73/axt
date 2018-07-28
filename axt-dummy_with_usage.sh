#/bin/bash

# HELP: Dummy command with usage
# USAGE: dummy [help] (me)

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

