#!/bin/sh

# HELP: Setup HANA Core git repository

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
if [[ ! -v AXT_USER ]] || [ -z "${AXT_USER}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
if [[ ! -v AXT_GIT_REPO_PATH ]] || [ -z "${AXT_GIT_REPO_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
if [[ ! -v AXT_GIT_REPO_SERVER ]] || [ -z "${AXT_GIT_REPO_SERVER}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


echo "AXT: setting up HANA Core repository in ${AXT_GIT_REPO_PATH} for user ${AXT_USER}"

mkdir -p ${AXT_GIT_REPO_PATH}

git clone ssh://${AXT_USER}@${AXT_GIT_REPO_SERVER} ${AXT_GIT_REPO_PATH}
