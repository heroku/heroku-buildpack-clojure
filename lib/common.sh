#!/usr/bin/env bash

# Displays a warning message to the user
function warning() {
	echo
	echo " !     WARNING: $*"
	echo
}

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

# Install node.js
function install_nodejs() {
	local version="${1:?}"
	local dir="${2:?}"
	local url="https://heroku-nodebin.s3.us-east-1.amazonaws.com/node/release/linux-x64/node-v${version}-linux-x64.tar.gz"

	echo "Downloading Node.js ${version}..."
	local code
	code=$(curl "${url}" -L --silent --fail --retry 5 --retry-max-time 15 --retry-connrefused --connect-timeout 5 -o /tmp/node.tar.gz --write-out "%{http_code}")
	if [[ "${code}" != "200" ]]; then
		echo "Unable to download Node.js version ${version}: ${code}"
		return 1
	fi

	tar xzf /tmp/node.tar.gz -C /tmp
	mv "/tmp/node-v${version}-linux-x64" "${dir}"
	chmod +x "${dir}/bin/"*
}

function detect_and_install_nodejs() {
	local buildDir="${1}"
	if [[ ! -d "${buildDir}/.heroku/nodejs" ]] && [[ "true" != "${SKIP_NODEJS_INSTALL:-}" ]]; then
		if grep -q lein-npm "${buildDir}/project.clj" || [[ -n "${NODEJS_VERSION:-}" ]]; then
			local nodejsVersion="${NODEJS_VERSION:-18.16.0}"
			echo "-----> Installing Node.js ${nodejsVersion}..."
			install_nodejs "${nodejsVersion}" "${buildDir}/.heroku/nodejs" 2>&1 | sed -u 's/^/       /'
			export PATH="${buildDir}/.heroku/nodejs/bin:${PATH}"
		fi
	fi
}

function install_jdk() {
	local install_dir="${1}"

	JVM_COMMON_BUILDPACK="${JVM_COMMON_BUILDPACK:-https://buildpack-registry.s3.us-east-1.amazonaws.com/buildpacks/heroku/jvm.tgz}"
	mkdir -p /tmp/jvm-common
	curl --fail --retry 3 --retry-connrefused --connect-timeout 5 --silent --location "${JVM_COMMON_BUILDPACK}" | tar xzm -C /tmp/jvm-common --strip-components=1

	# Temporarily disable set -u for jvm-common scripts that aren't compatible with strict mode
	set +u
	# shellcheck source=/dev/null
	source /tmp/jvm-common/bin/java
	# shellcheck source=/dev/null
	source /tmp/jvm-common/opt/jdbc.sh

	install_java_with_overlay "${install_dir}"
	set -u
}
