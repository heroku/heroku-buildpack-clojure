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
  local version="$1"
  local dir="$2"
  local os="linux"
  local cpu="x64"

  echo "Downloading and installing node $version..."
  local download_url="https://s3pository.heroku.com/node/v$version/node-v$version-$os-$cpu.tar.gz"
  curl "$download_url" --silent --show-error --fail -o /tmp/node.tar.gz || (echo "Unable to download node $version; does it exist?" && false)
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

# Load config vars into environment
export_env_dir() {
  env_dir=$1
  whitelist_regex=${2:-''}
  blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH|JAVA_OPTS)$'}
  if [ -d "$env_dir" ]; then
    for e in $(ls $env_dir); do
      echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      export "$e=$(cat $env_dir/$e)"
      :
    done
  fi
}
