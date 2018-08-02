#!/bin/sh

# HELP: Edit ~/.bashrc & re-source

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi
echo ${HOME}
eval ${AXT_EDITOR} "${HOME}/.bashrc"

exec bash
