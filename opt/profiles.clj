{:user {:mirrors {#"central|clojars"
                  "http://s3pository.herokuapp.com/clojure"}
        :aliases {"repl" "standalone-repl"}
        :plugins [[lein-standalone-repl "0.1.3"]]}
 :production {:mirrors {#"central|clojars"
                        "http://s3pository.herokuapp.com/clojure"}}
 :heroku {:mirrors {#"central|clojars"
                    "http://s3pository.herokuapp.com/clojure"}}}