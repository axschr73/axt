#!/bin/sh

# HELP: Rebase local branch on current remote branch

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

echo "Rebasing local branch '${AXT_GIT_LOCAL_BRANCH}' on remote branch 'origin/${AXT_GIT_REMOTE_BRANCH}'"

git fetch
git rebase ${AXT_GIT_REMOTE_BRANCH}

