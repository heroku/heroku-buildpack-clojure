#!/usr/bin/env bash

is_lein_2() {
  local buildDir=${1}
  if [ "$(grep ":min-lein-version[[:space:]]\+\"2" $BUILD_DIR/project.clj)" != "" ]; then
    return 0
  else
    return 1
  fi
}
