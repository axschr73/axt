#!/bin/sh

# HELP: Reset local branch to current remote branch

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

echo "Resetting local branch '${AXT_GIT_LOCAL_BRANCH}' on remote branch '${AXT_GIT_REMOTE_BRANCH}"

git fetch
git reset --hard ${AXT_GIT_REMOTE_BRANCH}
