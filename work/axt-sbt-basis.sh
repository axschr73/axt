#!/bin/sh

# HELP: Execute all tests registered for executable 'test_basis'

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

TESTSET="CONTI"

if (( $# == 1 )); then
	TESTSET=$1
fi

sbt build:test.${TESTSET} filter:test_basis serial