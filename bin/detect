#!/usr/bin/env bash
# bin/use <build-dir>

if [ -f $1/project.clj ]; then
  grep ":min-lein-version[[:space:]]\+\"2" $1/project.clj > /dev/null
  if [ $? -eq 0 ]; then
    echo "Clojure (Leiningen 2)" && exit 0
  else
    echo "Clojure" && exit 0
  fi
else
  (>&2 echo "Could not find a 'project.clj' file! Please ensure it exists and is checked into Git.")
  exit 1
fi
