#!/usr/bin/env bash

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

_createBaseProject() {
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

_createUberJarProjectFile() {
  cat > ${BUILD_DIR}/project.clj <<EOF
(defproject clojure-getting-started "1.0.0-SNAPSHOT"
  :description "Demo Clojure web app"
  :url "http://clojure-getting-started.herokuapp.com"
  :license {:name "Eclipse Public License v1.0"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]
                [compojure "1.1.8"]
                [ring/ring-jetty-adapter "1.2.2"]
                [environ "0.5.0"]]
  :min-lein-version "2.0.0"
  :plugins [[environ/environ.lein "0.2.1"]]
  :hooks [environ.leiningen.hooks]
  :uberjar-name "clojure-getting-started-standalone.jar"
  :profiles {:production {:env {:production true}}})
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
  _createBaseProject
  _createSysProps "1.6"
  compile
  assertCapturedSuccess
  assertCaptured "Installing OpenJDK 1.6...done"
  assertCaptured "Downloading: leiningen-1.7.1-standalone.jar"
}

testCompileJdk7() {
  _createBaseProject
  _createSysProps "1.7"
  compile
  assertCapturedSuccess
  assertCaptured "Installing OpenJDK 1.7...done"
  assertCaptured "Downloading: leiningen-1.7.1-standalone.jar"
}

testCompileJdk8() {
  _createBaseProject
  compile
  assertCapturedSuccess
  assertCaptured "Installing OpenJDK 1.8...done"
  assertCaptured "WARNING: no :min-lein-version found in project.clj; using 1.7.1."
  assertCaptured "To use Leiningen 2.x, add this to project.clj: :min-lein-version \"2.0.0\""
  assertCaptured "Downloading: leiningen-1.7.1-standalone.jar"
  assertCaptured "No Procfile; using \"web: lein trampoline run\"."
}

testMinLeinVersion() {
  _createBaseProject
  _createLein2ProjectFile
  compile
  assertCapturedSuccess
  assertNotCaptured "WARNING: no :min-lein-version found in project.clj; using 1.7.1."
  assertCaptured "Downloading: leiningen-2.5.1-standalone.jar"
  assertCaptured "No Procfile; using \"web: lein with-profile production trampoline run\"."
}

testUberJar() {
  _createBaseProject
  _createUberJarProjectFile
  compile
  assertCapturedSuccess
  assertCaptured "Running: lein uberjar"
}

testCacheLein() {
  _createBaseProject

  compile
  assertCapturedSuccess
  assertNotCaptured "Using cached Leiningen"

  compile
  assertCapturedSuccess
  assertCaptured "Using cached Leiningen"
}
