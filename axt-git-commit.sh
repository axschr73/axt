#!/bin/sh

# HELP: Stage & commit all changed files (incuding new & deleted)

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

git add -A
git commit
