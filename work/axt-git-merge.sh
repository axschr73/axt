#!/bin/sh

# HELP: Merge one branch to another via local branch
# USAGE: git merge [show-diff] <local branch> <remote source> <remote destination>
# USAGE:   - show-diff         : show commit log diff after merge
# USAGE:   - local branch      : local branch tracking remote destiantion
# USAGE:   - remote source     : remote source to merge from (w/o 'origin/')
# USAGE:   - remote destination: remote destination to merge into (w/o 'origin/')

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

if (( $# == 3 )); then
	SOURCE_BRANCH=$1
	LOCAL_BRANCH=$2
	TARGET_BRANCH=$3
elif (( $# == 4 )); then
	if [ "$1" = "show-diff" ]; then
		SHOW_DIFF="$1"
	else
		echo "AXT ERROR: Invalid value for (optional) 'show-diff': '$1'"
		exit 1
	fi
	SOURCE_BRANCH=$2
	LOCAL_BRANCH=$3
	TARGET_BRANCH=$4
else
	if (( $# < 3 )); then
		echo "AXT ERROR: Missing parameters for subcommand 'git merge'"
	else
		echo "AXT ERROR: Too many parameters for subcommand 'git merge'"
	fi
	exit 1
fi


echo "Merging ${LOCAL_BRANCH}@origin/${SOURCE_BRANCH} => origin/${TARGET_BRANCH}"

git fetch
git checkout -B ${LOCAL_BRANCH} origin/${TARGET_BRANCH}
git reset --hard origin/${TARGET_BRANCH}

git merge --no-ff --no-commit origin/${SOURCE_BRANCH}

MERGE_RC=$?
if [ ${MERGE_RC} -eq 1 ]; then
    echo "merge.sh: git merge found conflicts, exit."
    exit;
elif [ ${MERGE_RC} -ne 0 ]; then
    echo "merge.sh: git merge error, exit."
    exit;
fi

git commit

git push gerrit HEAD:refs/for/${TARGET_BRANCH}

PUSH_RC=$?
if [ ${PUSH_RC} -eq 0 ]; then
	if [ -n "${SHOW_DIFF}" ]; then
		echo "COMMIT LOG DIFF ${LOCAL_BRANCH}@origin/${SOURCE_BRANCH} => origin/${TARGET_BRANCH}"
		echo "---------------------------------------------------------------------------"
		git log origin/${SOURCE_BRANCH} ^origin/${TARGET_BRANCH} --no-merges --oneline --abbrev-commit | cat
		echo "---------------------------------------------------------------------------"
	fi
fi

git checkout ${AXT_GIT_LOCAL_BRANCH}

