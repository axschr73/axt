#!/bin/sh

# HELP: Choose local branch from list

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
command -v peco  >/dev/null 2>&1 || { echo >&2 "AXT ERROR: axt git branch requires helper 'peco'!"; exit 1; }


SELECTION=$(git branch | peco)
NEW_BRANCH="${SELECTION:2:${#SELECTION}}"

git checkout ${NEW_BRANCH}
