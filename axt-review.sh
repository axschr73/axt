#!/bin/sh

# HELP: AXT's gerrit tools (use subcommands)
# USAGE: gerrit merge | push

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


/area51/config/tools/noarch/reviewPlease/reviewPlease $@

