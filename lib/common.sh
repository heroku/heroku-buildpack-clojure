#!/usr/bin/env bash

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
  local url="https://heroku-nodebin-staging.s3.us-east-1.amazonaws.com/node/release/linux-x64/node-v${version}-linux-x64.tar.gz"

  echo "Downloading Node.js $version..."
  local code=$(curl "$url" -L --silent --fail --retry 5 --retry-max-time 15 --retry-connrefused --connect-timeout 5 -o /tmp/node.tar.gz --write-out "%{http_code}")
  if [ "$code" != "200" ]; then
    echo "Unable to download Node.js version ${version}: $code"
    return false
  fi

  tar xzf /tmp/node.tar.gz -C /tmp
  mv /tmp/node-v$version-linux-x64 $dir
  chmod +x $dir/bin/*
}

detect_and_install_nodejs() {
  local buildDir=${1}
  if [ ! -d ${buildDir}/.heroku/nodejs ] && [ "true" != "$SKIP_NODEJS_INSTALL" ]; then
    if [ "$(grep lein-npm ${buildDir}/project.clj)" != "" ] || [ -n "$NODEJS_VERSION"  ]; then
      nodejsVersion=${NODEJS_VERSION:-18.16.0}
      echo "-----> Installing Node.js ${nodejsVersion}..."
      install_nodejs ${nodejsVersion} ${buildDir}/.heroku/nodejs 2>&1 | sed -u 's/^/       /'
      export PATH=${buildDir}/.heroku/nodejs/bin:$PATH
    fi
  fi
}

install_jdk() {
  local install_dir=${1}

  let start=$(nowms)
  JVM_COMMON_BUILDPACK=${JVM_COMMON_BUILDPACK:-https://buildpack-registry.s3.us-east-1.amazonaws.com/buildpacks/heroku/jvm.tgz}
  mkdir -p /tmp/jvm-common
  curl --fail --retry 3 --retry-connrefused --connect-timeout 5 --silent --location $JVM_COMMON_BUILDPACK | tar xzm -C /tmp/jvm-common --strip-components=1
  source /tmp/jvm-common/bin/util
  source /tmp/jvm-common/bin/java
  source /tmp/jvm-common/opt/jdbc.sh
  mtime "jvm-common.install.time" "${start}"

  let start=$(nowms)
  install_java_with_overlay ${install_dir}
  mtime "jvm.install.time" "${start}"
}
