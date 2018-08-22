#!/bin/sh

# HELP: AXT's git tools (use subcommands)
# USAGE: git branch | log | push | rebase | remote | reset | rebase | setup

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi


export AXT_GIT_LOCAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
export AXT_GIT_REMOTE_BRANCH="$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))"
export AXT_GIT_REMOTE_BRANCH_NAME=${AXT_GIT_REMOTE_BRANCH##origin/}

if (( $# >= 1 )); then
	COMMAND="axt-git-${1}.sh"
	COMMAND_FILES=(`eval find ${AXT_PATH} -name ${COMMAND} -print`)
	if ((${#COMMAND_FILES[@]} == 1 )); then
		shift
		eval ${COMMAND_FILES[0]} $@
	else
		echo "AXT ERROR: sub command 'git ${1}' not found."
	fi
else
	echo "AXT ERROR: command 'git' needs a subcommand"
fi

