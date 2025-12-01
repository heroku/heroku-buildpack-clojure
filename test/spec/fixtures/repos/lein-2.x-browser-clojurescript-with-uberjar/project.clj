(defproject heroku-minimal-clojure "0.1.0"
  :description "A minimal Clojure HTTP application"
  :dependencies [[org.clojure/clojure "1.12.3"]
                 [org.clojure/clojurescript "1.11.60"]
                 [ring/ring-core "1.9.6"]
                 [ring/ring-jetty-adapter "1.9.6"]
                 [ring/ring-defaults "0.3.4"]
                 [compojure "1.7.0"]]
  :plugins [[lein-cljsbuild "1.1.8"]]
  :main com.heroku.ci.core
  :aot [com.heroku.ci.core]
  :uberjar-name "app-standalone.jar"
  :min-lein-version "2.0.0"
  :resource-paths ["resources"]
  :cljsbuild {:builds [{:source-paths ["src/cljs"]
                        :compiler {:output-to "resources/public/app.js"
                                   :optimizations :simple
                                   :pretty-print true}}]})
