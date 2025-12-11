; This project is intentionally very simple since it's hard to create a working HTTP service in 2025 with leiningen 1.x
; that does not fail with download errors. Since this fixture will be removed soon anyways, having such a simple
; project serves its purpose well enough.
(defproject sample "0.1.0-SNAPSHOT"
   :repositories [["central-https" {:url "https://repo1.maven.org/maven2"}]
                  ["clojars-https" {:url "https://clojars.org/repo/"}]]
   :omit-default-repositories true
   :dependencies [[org.clojure/clojure "1.5.1"]]
   :main ^:skip-aot sample.core
   :target-path "target/%s")
