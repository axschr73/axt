#!/bin/sh

# HELP: Edit ~/.bashrc & re-source

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
test -v AXT_EDITOR || { echo >&2 "AXT ERROR: \$AXT_EDITOR not set, run 'axt setup'"; exit 1; }


eval ${AXT_EDITOR} "${HOME}/.bashrc"

exec bash
