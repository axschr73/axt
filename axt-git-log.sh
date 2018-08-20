#!/bin/sh

# HELP: peco'd git log viewer

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

git log --oneline --abbrev-commit | peco

