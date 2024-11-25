#!/bin/sh

# HELP: View git repository with tig

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
if [[ ! -v AXT_GIT_LOCAL_BRANCH ]]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
if [[ ! -v AXT_GIT_REMOTE_BRANCH ]]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


tig $@
