#!/usr/bin/env bash

export BUILDPACK_STDLIB_URL="https://lang-common.s3.amazonaws.com/buildpack-stdlib/v7/stdlib.sh"

cache_copy() {
  rel_dir=$1
  from_dir=$2
  to_dir=$3
  rm -rf $to_dir/$rel_dir
  if [ -d $from_dir/$rel_dir ]; then
    mkdir -p $to_dir/$rel_dir
    cp -pr $from_dir/$rel_dir/. $to_dir/$rel_dir
  fi
}

# Install node.js
install_nodejs() {
  local version="${1:?}"
  local dir="${2:?}"
  local os="linux"
  local cpu="x64"
  local platform="$os-$cpu"

  echo "Resolving node version $version..."
  if ! read number url < <(curl --silent --get --retry 5 --retry-max-time 15 --data-urlencode "range=$version" "https://nodebin.herokai.com/v1/node/$platform/latest.txt"); then
    local error=$(curl --silent --get --retry 5 --retry-max-time 15 --data-urlencode "range=$version" "https://nodebin.herokai.com/v1/node/$platform/latest.txt")
    if [[ $error = "No result" ]]; then
      echo "Could not find Node version corresponding to version requirement: $version";
    else
      echo "Error: Invalid semantic version \"$version\""
    fi
  fi

  echo "Downloading and installing node $version..."
  local code=$(curl "$url" -L --silent --fail --retry 5 --retry-max-time 15 -o /tmp/node.tar.gz --write-out "%{http_code}")
  if [ "$code" != "200" ]; then
    echo "Unable to download node: $code" && false
  fi
  tar xzf /tmp/node.tar.gz -C /tmp
  mv /tmp/node-v$version-$os-$cpu $dir
  chmod +x $dir/bin/*
}

detect_and_install_nodejs() {
  local buildDir=${1}
  if [ ! -d ${buildDir}/.heroku/nodejs ] && [ "true" != "$SKIP_NODEJS_INSTALL" ]; then
    if [ "$(grep lein-npm ${buildDir}/project.clj)" != "" ] || [ -n "$NODEJS_VERSION"  ]; then
      nodejsVersion=${NODEJS_VERSION:-4.2.1}
      echo "-----> Installing Node.js ${nodejsVersion}..."
      install_nodejs ${nodejsVersion} ${buildDir}/.heroku/nodejs 2>&1 | sed -u 's/^/       /'
      export PATH=${buildDir}/.heroku/nodejs/bin:$PATH
    fi
  fi
}

install_jdk() {
  local install_dir=${1}

  let start=$(nowms)
  JVM_COMMON_BUILDPACK=${JVM_COMMON_BUILDPACK:-https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/jvm.tgz}
  mkdir -p /tmp/jvm-common
  curl --retry 3 --silent --location $JVM_COMMON_BUILDPACK | tar xzm -C /tmp/jvm-common --strip-components=1
  source /tmp/jvm-common/bin/util
  source /tmp/jvm-common/bin/java
  source /tmp/jvm-common/opt/jdbc.sh
  mtime "jvm-common.install.time" "${start}"

  let start=$(nowms)
  install_java_with_overlay ${install_dir}
  mtime "jvm.install.time" "${start}"
}
