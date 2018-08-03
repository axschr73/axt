#!/bin/sh

# HELP: Update AXT

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

git fetch
git rebase origin/${AXT_BRANCH}