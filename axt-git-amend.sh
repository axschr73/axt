#!/bin/sh

# HELP: Amend last commit with all changed files (including new/deleted)

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


git add -A
git commit --amend
