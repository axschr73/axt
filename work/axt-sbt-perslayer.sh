#!/bin/sh

# HELP: Execute all tests registered for executable 'test_persistencelayer_da'

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

TESTSET="CONTI"

if (( $# == 1 )); then
	TESTSET=$1
fi

hm build -b Optimized test_persistencelayer_da
${AXT_GIT_REPO_PATH}/nutest/sbt/commands/run_tests.sh -f ${AXT_GIT_REPO_PATH}/nutest/testscripts/config/DAPersistenceLayerTestDescription.csv -c opt -p linux -T 40 -x ${AXT_HM_BUILD_PATH}/opt/gen ${TESTSET}
