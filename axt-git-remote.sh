#!/bin/sh

# HELP: Switch to new remote branch (and use/create matching or user-defined local branch)
# USAGE: git remote [local_branch]
# USAGE:   - local_branch: local branch name to use. 
# USAGE:     If not specified, remote branch name will be used. 

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi
command -v peco  >/dev/null 2>&1 || { echo >&2 "AXT ERROR: axt git remote requires helper 'peco'!"; exit; }


if (( $# <= 1 )); then
	NEW_REMOTE_BRANCH=$(git branch -r | tail -n +2 | sed 's/  origin\/*//' | peco)
	
	if (( $# == 0 )); then
		NEW_LOCAL_BRANCH="${NEW_REMOTE_BRANCH}"
	else
		NEW_LOCAL_BRANCH="$1"
	fi
	
	echo "AXT: switching to ${NEW_LOCAL_BRANCH}@origin/${NEW_REMOTE_BRANCH}"
	
	git fetch 
	git checkout -B ${NEW_LOCAL_BRANCH} origin/${NEW_REMOTE_BRANCH}
	git reset --hard origin/${NEW_REMOTE_BRANCH}
else
	echo "AXT ERROR: too many paramters for subcommand 'git remote'"
fi



