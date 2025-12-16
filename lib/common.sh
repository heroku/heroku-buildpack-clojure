#!/usr/bin/env bash

# Returns current time in milliseconds since epoch
function nowms() {
	date +%s%3N
}

# Exports environment variables from ENV_DIR, with optional whitelist and blacklist
# Usage: export_env ENV_DIR WHITELIST BLACKLIST
function export_env() {
	local env_dir="${1}"
	local whitelist="${2:-}"
	local blacklist_pattern="${3:-}"

	# Build blacklist regex - always exclude these plus any custom patterns
	local blacklist="^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH"
	if [[ -n "${blacklist_pattern}" ]]; then
		blacklist="${blacklist}|${blacklist_pattern}"
	fi
	blacklist="${blacklist})$"

	if [[ -d "${env_dir}" ]]; then
		for env_file in "${env_dir}"/*; do
			[[ -f "${env_file}" ]] || continue
			local env_name
			env_name=$(basename "${env_file}")
			if echo "${env_name}" | grep -E "${whitelist}" | grep -qvE "${blacklist}"; then
				export "${env_name}=$(cat "${env_file}")"
			fi
		done
	fi
}

function cache_copy() {
	local rel_dir="${1}"
	local from_dir="${2}"
	local to_dir="${3}"
	rm -rf "${to_dir:?}/${rel_dir}"
	if [[ -d "${from_dir}/${rel_dir}" ]]; then
		mkdir -p "${to_dir}/${rel_dir}"
		cp -pr "${from_dir}/${rel_dir}/." "${to_dir}/${rel_dir}"
	fi
}
