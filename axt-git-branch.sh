#!/bin/sh

# HELP: Switch local branch

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

SELECTION=$(git branch | peco)
NEW_BRANCH="${SELECTION:2:${#SELECTION}}"

git checkout ${NEW_BRANCH}



