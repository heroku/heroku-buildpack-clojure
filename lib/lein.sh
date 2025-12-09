#!/usr/bin/env bash

function calculate_lein_build_task() {
	local buildDir="${1}"
	if grep -q :uberjar-name "${buildDir}/project.clj"; then
		export LEIN_BUILD_TASK="${LEIN_BUILD_TASK:-uberjar}"
		export LEIN_INCLUDE_IN_SLUG="${LEIN_INCLUDE_IN_SLUG:-no}"
	elif grep -q lein-npm "${buildDir}/project.clj"; then
		export LEIN_BUILD_TASK="${LEIN_BUILD_TASK:-with-profile production do deps, compile :all}"
	else
		export LEIN_BUILD_TASK="${LEIN_BUILD_TASK:-with-profile production compile :all}"
	fi
}

function is_lein_2() {
	local buildDir="${1}"
	if grep -q ":min-lein-version[[:space:]]\+\"2" "${BUILD_DIR}/project.clj"; then
		return 0
	else
		return 1
	fi
}
