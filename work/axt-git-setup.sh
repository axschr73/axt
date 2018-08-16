#!/bin/sh

# HELP: Setup HANA Core git repository

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

echo "AXT: setting up HANA Core repository in ${AXT_GIT_REPO_PATH} for user ${AXT_USER}"

mkdir -p ${AXT_GIT_REPO_PATH}

git clone ssh://${AXT_USER}@${AXT_GIT_REPO_SERVER} ${AXT_GIT_REPO_PATH}
