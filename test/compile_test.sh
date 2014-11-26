#!/usr/bin/env bash

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

_createNoLeinProject() {
  cat > ${BUILD_DIR}/project.clj <<EOF
(defproject sample "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.5.1"]]
  :main ^:skip-aot sample.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
EOF

  mkdir -p ${BUILD_DIR}/source/sample

  cat > ${BUILD_DIR}/source/sample/core.clj <<EOF
(ns sample.core
  (:gen-class))

(defn -main [& args]
  (println "Welcome to my project! These are your args:" args))
EOF
}

_createLein2ProjectFile() {
  cat > ${BUILD_DIR}/project.clj <<EOF
  (defproject sample "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
  :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.5.1"]]
  :min-lein-version "2.0.0"
  :main ^:skip-aot sample.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
EOF
}

_createSysProps() {
  local jdkVersion=${1:-"1.8"}
  cat > ${BUILD_DIR}/system.properties <<EOF
java.runtime.version=${jdkVersion}
EOF
}

# Tests

testCompileJdk6() {
  _createNoLeinProject
  _createSysProps "1.6"
  compile
  assertCapturedSuccess
  assertCaptured "Installing OpenJDK 1.6...done"
  assertCaptured "Downloading: leiningen-1.7.1-standalone.jar"
}

testCompileJdk7() {
  _createNoLeinProject
  _createSysProps "1.7"
  compile
  assertCapturedSuccess
  assertCaptured "Installing OpenJDK 1.7...done"
  assertCaptured "Downloading: leiningen-1.7.1-standalone.jar"
}

testCompileJdk8() {
  _createNoLeinProject
  compile
  assertCapturedSuccess
  assertCaptured "Installing OpenJDK 1.8...done"
  assertCaptured "WARNING: no :min-lein-version found in project.clj; using 1.7.1."
  assertCaptured "To use Leiningen 2.x, add this to project.clj: :min-lein-version \"2.0.0\""
  assertCaptured "Downloading: leiningen-1.7.1-standalone.jar"
}

testMinLeinVersion() {
  _createNoLeinProject
  _createLein2ProjectFile
  compile
  assertCapturedSuccess
  assertNotCaptured "WARNING: no :min-lein-version found in project.clj; using 1.7.1."
  assertCaptured "Downloading: leiningen-2.4.2-standalone.jar"
}
