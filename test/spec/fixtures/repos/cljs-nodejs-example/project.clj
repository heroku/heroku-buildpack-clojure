(defproject node-js-test "0.1.0-SNAPSHOT"
  :description "cljs-nodejs-example: example ClojureScript node.js app"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0"]
                 [org.clojure/clojurescript "1.7.48"]
                 [org.clojure/core.async "0.1.346.0-17112a-alpha"]
                 [reagent "0.5.1"]
                 [kioo "0.4.1"]]
  :min-lein-version "2.0.0"
  :hooks [leiningen.cljsbuild]
  :plugins [[lein-cljsbuild "1.1.0"]]
  :cljsbuild {
              :builds [{
                        :source-paths ["src/myexample"]
                        :compiler {:output-to "target/js/myexample.js"
                                   :target :nodejs
                                   :optimizations :simple
                                   :pretty-print true }}]})
