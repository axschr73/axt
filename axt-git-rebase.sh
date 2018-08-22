#!/bin/sh

# HELP: Rebase local branch on current remote branch

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi
if [[ ! -v AXT_GIT_LOCAL_BRANCH ]]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi
if [[ ! -v AXT_GIT_REMOTE_BRANCH ]]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi


echo "Rebasing local branch '${AXT_GIT_LOCAL_BRANCH}' on remote branch '${AXT_GIT_REMOTE_BRANCH}'"

git fetch
git rebase ${AXT_GIT_REMOTE_BRANCH}

