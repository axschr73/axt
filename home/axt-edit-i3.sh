#!/bin/sh

# HELP: Edit i3 config

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

eval ${AXT_EDITOR} "${HOME}/.config/i3/config"

