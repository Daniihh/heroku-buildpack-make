#!/bin/bash

function test() {
	echo -e "\u001b[34mTesting: \u001b[0m$1"

	[ "$2" != true ]
	IS_OPPOSITE=$?
	if [ $IS_OPPOSITE -eq 0 ]; then
		make $1 > /dev/null
	else
		make $1 &> /dev/null
	fi
	[ $? -eq 0 ]
	MAKE_RES=$?
	
	if (( $MAKE_RES ^ $IS_OPPOSITE )); then
		echo -e "\u001b[31mFailed: \u001b[0m$1"
		exit 1
	fi
	echo -e "\u001b[32mPassed: \u001b[0m$1"
}

cd $(dirname $0)

# Detection Tests
test detect_none true
test detect_lower_case
test detect_upper_case
test detect_gnu

# Compilation Tests
# test compile_no_targets
# test compile_unspecified_target

make clean
