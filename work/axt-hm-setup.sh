#!/bin/sh

# HELP: <add short help text (one line)>
# USAGE: <add usage in format axt <command> ... if your command needs paramters. Otherwise, delete this line>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

echo "AXT: setting up HappyMake"

OLD_PATH=$(pwd)
cd ${AXT_GIT_REPO_PATH}

git checkout origin/meta -- setup.py setup.sh && git reset setup.py setup.sh && ./setup.sh && rm setup.py setup.sh

hm remote add -u ${AXT_USER} -n win64 ${AXT_HM_REMOTE_WIN}
hm remote add -u ${AXT_USER} -n ppc64le ${AXT_HM_REMOTE_PPC}

cd ${OLD_PATH}
