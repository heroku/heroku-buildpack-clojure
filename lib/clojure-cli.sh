#!/usr/bin/env bash

is_tools_deps() {
  local buildDir=${1}
  if [[ -f $buildDir/deps.edn && ! -f $buildDir/project.clj ]]; then
    return 0
  else
    return 1
  fi
}
