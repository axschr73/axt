#!/bin/sh

# HELP: peco'd git log viewer

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi
command -v peco  >/dev/null 2>&1 || { echo >&2 "AXT ERROR: axt git log requires helper 'peco'!"; exit }


git log --oneline --abbrev-commit | peco

