#!/bin/sh

# HELP: <add short help text (one line)>
# USAGE: <add usage in format axt <command> ... if your command needs paramters. Otherwise, delete this line>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

hm init -f -b Debug:${AXT_HM_BUILD_PATH}/dbg
hm init -f -b Optimized:${AXT_HM_BUILD_PATH}/opt
hm init -f -b Release:${AXT_HM_BUILD_PATH}/rel
hm init -f -b cov_opt=linuxx86_64-gcc48_hdbcov-optimized:${AXT_HM_BUILD_PATH}/cov_opt
hm init -f -b asan_opt=linuxx86_64-clang_asan-optimized:${AXT_HM_BUILD_PATH}/asan_opt

hm init --remote win64 -f -b win64dbg=Debug:${AXT_HM_BUILD_PATH}/win64dbg
hm init --remote win64 -f -b win64opt=Optimized:${AXT_HM_BUILD_PATH}/win64opt
hm init --remote win64 -f -b win64rel=Release:${AXT_HM_BUILD_PATH}/win64rel

hm init --remote ppc64le -f -b ppc64le_dbg=Debug:${AXT_HM_BUILD_PATH}/ppc64le_dbg
hm init --remote ppc64le -f -b ppc64le_opt=Optimized:${AXT_HM_BUILD_PATH}/ppc64le_opt
hm init --remote ppc64le -f -b ppc64le_rel=Release:${AXT_HM_BUILD_PATH}/ppc64le_rel
