{:user {:mirrors {"central" "http://s3pository.herokuapp.com/maven-central"
                  "clojars" "http://s3pository.herokuapp.com/clojars"}
        :aliases {"repl" "standalone-repl"}
        :plugins [[lein-standalone-repl "0.1.3"]]}
 :production {:mirrors {"central" "http://s3pository.herokuapp.com/maven-central"
                        "clojars" "http://s3pository.herokuapp.com/clojars"}}
 :heroku {:mirrors {"central" "http://s3pository.herokuapp.com/maven-central"
                    "clojars" "http://s3pository.herokuapp.com/clojars"}}}