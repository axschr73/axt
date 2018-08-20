#!/bin/sh

# HELP: Push local branch to current remote branch

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

echo "Pushing local branch '${AXT_GIT_LOCAL_BRANCH}' to remote branch '${AXT_GIT_REMOTE_BRANCH}'"

git push gerrit HEAD:refs/for/${AXT_GIT_REMOTE_BRANCH_NAME}

