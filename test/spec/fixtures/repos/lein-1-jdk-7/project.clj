(defproject sample "0.1.0-SNAPSHOT"
   :description "FIXME: write description"
   :url "http://example.com/FIXME"
   :license {:name "Eclipse Public License"
             :url "http://www.eclipse.org/legal/epl-v10.html"}
   :repositories [["central-https" {:url "https://repo1.maven.org/maven2"}]
                  ["clojars-https" {:url "https://clojars.org/repo/"}]]
   :omit-default-repositories true
   :dependencies [[org.clojure/clojure "1.5.1"]]
   :main ^:skip-aot sample.core
   :target-path "target/%s"
   :profiles {:uberjar {:aot :all}})
