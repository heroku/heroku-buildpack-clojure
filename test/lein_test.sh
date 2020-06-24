#!/usr/bin/env bash

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh
. ${BUILDPACK_HOME}/lib/lein.sh

test_is_lein_2_positive() {
  cat > ${BUILD_DIR}/project.clj <<EOF
(defproject clojure-getting-started "1.0.0-SNAPSHOT"
    :description "Demo Clojure web app"
    :url "http://clojure-getting-started.herokuapp.com"
    :license {:name "Eclipse Public License v1.0"
              :url "http://www.eclipse.org/legal/epl-v10.html"}
    :repositories [["central-https" {:url "https://repo1.maven.org/maven2"}]
                   ["clojars-https" {:url "https://clojars.org/repo/"}]]
    :omit-default-repositories true
    :dependencies [[org.clojure/clojure "1.6.0"]
                   [compojure "1.1.8"]
                   [ring/ring-jetty-adapter "1.2.2"]
                   [environ "0.5.0"]]
  :min-lein-version "2.0.0"
  :hooks [environ.leiningen.hooks]
  :uberjar-name "clojure-getting-started-standalone.jar"
  :profiles {:production {:env {:production true}}})
EOF
  capture is_lein_2 ${BUILD_DIR}
  assertCapturedSuccess
}

test_is_lein_2_negative() {
  cat > ${BUILD_DIR}/project.clj <<EOF
(defproject clojure-getting-started "1.0.0-SNAPSHOT"
    :description "Demo Clojure web app"
    :url "http://clojure-getting-started.herokuapp.com"
    :license {:name "Eclipse Public License v1.0"
              :url "http://www.eclipse.org/legal/epl-v10.html"}
   :repositories [["central-https" {:url "https://repo1.maven.org/maven2"}]
                 ["clojars-https" {:url "https://clojars.org/repo/"}]]
    :omit-default-repositories true
    :dependencies [[org.clojure/clojure "1.6.0"]
                   [compojure "1.1.8"]
                   [ring/ring-jetty-adapter "1.2.2"]
                   [environ "0.5.0"]]
  :hooks [environ.leiningen.hooks]
  :profiles {:production {:env {:production true}}})
EOF
  capture is_lein_2 ${BUILD_DIR}
  assertTrue "Expected captured exit code to be greater than 0; was <${RETURN}>" "[ ${RETURN} -gt 0 ]"
}

test_calculate_lein_build_task_uberjar() {
  unset LEIN_BUILD_TASK
  cat > ${BUILD_DIR}/project.clj <<EOF
(defproject clojure-getting-started "1.0.0-SNAPSHOT"
    :description "Demo Clojure web app"
    :url "http://clojure-getting-started.herokuapp.com"
    :license {:name "Eclipse Public License v1.0"
              :url "http://www.eclipse.org/legal/epl-v10.html"}
    :repositories [["central-https" {:url "https://repo1.maven.org/maven2"}]
                   ["clojars-https" {:url "https://clojars.org/repo/"}]]
    :omit-default-repositories true
    :dependencies [[org.clojure/clojure "1.6.0"]
                   [compojure "1.1.8"]
                   [ring/ring-jetty-adapter "1.2.2"]
                   [environ "0.5.0"]]
  :min-lein-version "2.0.0"
  :hooks [environ.leiningen.hooks]
  :uberjar-name "clojure-getting-started-standalone.jar"
  :profiles {:production {:env {:production true}}})
EOF
  capture calculate_lein_build_task ${BUILD_DIR}
  assertEquals "Expected uberjar build task" "uberjar" "$LEIN_BUILD_TASK"
  assertEquals "Expected lein not included in slug" "no" "$LEIN_INCLUDE_IN_SLUG"
  unset LEIN_BUILD_TASK
}

test_calculate_lein_build_task_production_compile() {
  unset LEIN_BUILD_TASK
  cat > ${BUILD_DIR}/project.clj <<EOF
(defproject clojure-getting-started "1.0.0-SNAPSHOT"
    :description "Demo Clojure web app"
    :url "http://clojure-getting-started.herokuapp.com"
    :license {:name "Eclipse Public License v1.0"
              :url "http://www.eclipse.org/legal/epl-v10.html"}
    :repositories [["central-https" {:url "https://repo1.maven.org/maven2"}]
                   ["clojars-https" {:url "https://clojars.org/repo/"}]]
    :omit-default-repositories true
    :dependencies [[org.clojure/clojure "1.6.0"]
                   [compojure "1.1.8"]
                   [ring/ring-jetty-adapter "1.2.2"]
                   [environ "0.5.0"]]
  :hooks [environ.leiningen.hooks]
  :profiles {:production {:env {:production true}}})
EOF
  capture calculate_lein_build_task ${BUILD_DIR}
  assertEquals "Expected compile build task" "with-profile production compile :all" "$LEIN_BUILD_TASK"
  unset LEIN_BUILD_TASK
}
