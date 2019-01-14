#!/usr/bin/env bash

calculate_lein_build_task() {
  local buildDir=${1}
  if [ "$(grep :uberjar-name $buildDir/project.clj)" != "" ]; then
    export LEIN_BUILD_TASK="${LEIN_BUILD_TASK:-uberjar}"
    export LEIN_INCLUDE_IN_SLUG="${LEIN_INCLUDE_IN_SLUG:-no}"
  elif [ "$(grep lein-npm $buildDir/project.clj)" != "" ]; then
    export LEIN_BUILD_TASK=${LEIN_BUILD_TASK:-"with-profile production do deps, compile :all"}
  else
    export LEIN_BUILD_TASK=${LEIN_BUILD_TASK:-"with-profile production compile :all"}
  fi
}

is_lein_2() {
  local buildDir=${1}
  if [ "$(grep ":min-lein-version[[:space:]]\+\"2" $BUILD_DIR/project.clj)" != "" ]; then
    return 0
  else
    return 1
  fi
}

install_rlwrap() {
  local buildDir="${1:?}"
  local cacheDir="${2:?}"

  APT_CACHE_DIR="$cacheDir/apt/cache"
  APT_STATE_DIR="$cacheDir/apt/state"
  APT_OPTIONS="-o debug::nolocking=true -o dir::cache=$APT_CACHE_DIR -o dir::state=$APT_STATE_DIR"

  mkdir -p "$APT_CACHE_DIR/archives/partial"
  mkdir -p "$APT_STATE_DIR/lists/partial"

  echo "-----> Installing rlwrap... "
  apt-get $APT_OPTIONS update | indent
  apt-get $APT_OPTIONS -y -d install --reinstall rlwrap | indent

  mkdir -p $buildDir/.profile.d
  cat <<EOF >$buildDir/.profile.d/rlwrap.sh
  export PATH="\$HOME/.heroku/apt/usr/bin:\$PATH"
  export LD_LIBRARY_PATH="\$HOME/.heroku/apt/usr/lib/x86_64-linux-gnu:\$HOME/.heroku/apt/usr/lib/i386-linux-gnu:\$HOME/.heroku/apt/usr/lib:\$LD_LIBRARY_PATH"
  export LIBRARY_PATH="\$HOME/.heroku/apt/usr/lib/x86_64-linux-gnu:\$HOME/.heroku/apt/usr/lib/i386-linux-gnu:\$HOME/.heroku/apt/usr/lib:\$LIBRARY_PATH"
  export INCLUDE_PATH="\$HOME/.heroku/apt/usr/include:\$INCLUDE_PATH"
  export CPATH="\$INCLUDE_PATH"
  export CPPPATH="\$INCLUDE_PATH"
  export PKG_CONFIG_PATH="\$HOME/.heroku/apt/usr/lib/x86_64-linux-gnu/pkgconfig:\$HOME/.heroku/apt/usr/lib/i386-linux-gnu/pkgconfig:\$HOME/.heroku/apt/usr/lib/pkgconfig:\$PKG_CONFIG_PATH"
  export PYTHONPATH="\$HOME/.heroku/apt/usr/lib/python2.7/dist-packages"
  export SCREENDIR="\$HOME/.heroku/apt/var/run/screen"
EOF

  for DEB in $(ls -1 $APT_CACHE_DIR/archives/*.deb); do
    dpkg -x $DEB $buildDir/.heroku/apt/
  done
  chmod +x $buildDir/.heroku/apt/usr/bin/*
}
