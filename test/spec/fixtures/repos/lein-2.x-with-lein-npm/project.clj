(defproject heroku-minimal-clojure "0.1.0"
  :description "A minimal Clojure HTTP application with lein-npm"
  :dependencies [[org.clojure/clojure "1.12.3"]
                 [ring/ring-core "1.9.6"]
                 [ring/ring-jetty-adapter "1.9.6"]
                 [ring/ring-defaults "0.3.4"]
                 [compojure "1.7.0"]]
  :plugins [[lein-npm "0.6.2"]]
  :main com.heroku.ci.core
  :aot [com.heroku.ci.core]
  :min-lein-version "2.0.0")
