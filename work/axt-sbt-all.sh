#!/bin/sh

# HELP: Execute all Basis/DataAccess tests registered with the Basis::TestFrame framework

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

TESTSET="CONTI"

if (( $# == 1 )); then
	TESTSET=$1
fi

sbt build:test.${TESTSET} serial