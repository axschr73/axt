#!/bin/sh

# HELP: Amend last commit with all changed files (including new/deleted)

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

git add -A
git commit --amend
