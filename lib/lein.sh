#!/usr/bin/env bash

# This is technically redundant, since all consumers of this lib will have enabled these,
# however, it helps Shellcheck realise the options under which these functions will run.
set -euo pipefail

BUILDPACK_DIR="$(cd "$(dirname "$(dirname "${BASH_SOURCE[0]}")")" && pwd)"

# shellcheck source=lib/output.sh
source "${BUILDPACK_DIR}/lib/output.sh"
# shellcheck source=lib/metrics.sh
source "${BUILDPACK_DIR}/lib/metrics.sh"

lein::get_project_property() {
	local project_file="${1}"
	shift
	local property_path=("${@}")

	local output
	if output=$("${BUILDPACK_DIR}/opt/get_project_property.clj" "${project_file}" "${property_path[@]}" 2>&1); then
		echo "${output}"
	else
		local exit_code=${?}

		if [[ ${exit_code} -eq 2 ]]; then
			output::error <<-EOF
				Error: Unable to parse project.clj

				Your project.clj file couldn't be parsed because it contains
				invalid Clojure syntax. This is usually caused by unbalanced
				parentheses or other syntax errors.

				project.clj contents:
				$(cat "${project_file}")

				Check your project.clj file for syntax errors. You can verify
				the syntax locally by running 'lein version' in your project
				directory.
			EOF

			metrics::set_string "failure_reason" "project-clj-malformed"
		fi

		return ${exit_code}
	fi
}
