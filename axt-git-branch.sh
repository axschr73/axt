#!/bin/sh

# HELP: Switch local branch

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi


SELECTION=$(git branch | peco)
NEW_BRANCH="${SELECTION:2:${#SELECTION}}"

git checkout ${NEW_BRANCH}



