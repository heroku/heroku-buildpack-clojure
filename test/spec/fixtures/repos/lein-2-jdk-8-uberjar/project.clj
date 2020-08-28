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
  :plugins [[environ/environ.lein "0.2.1"]]
  :hooks [environ.leiningen.hooks]
  :uberjar-name "clojure-getting-started-standalone.jar"
  :profiles {:production {:env {:production true}}})
