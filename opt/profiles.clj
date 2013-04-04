{:user {:mirrors {"central" "http://s3pository.herokuapp.com/maven-central"
                  ;; TODO: re-enable once clojars releases repo is up
                  ;; "clojars" "http://s3pository.herokuapp.com/clojars"
                  }
        :aliases {"repl" ["update-in" ":dependencies" "conj" "[reply \"0.1.6\"]" "--"
                          "with-profile" "production" "trampoline" "run" "-m"
                          "reply.main/launch-standalone" "nil"]}}
 :production {:mirrors {"central" "http://s3pository.herokuapp.com/maven-central"
                        ;; "clojars" "http://s3pository.herokuapp.com/clojars"
                        }
              :offline true}
 :heroku {:mirrors {"central" "http://s3pository.herokuapp.com/maven-central"
                    ;; "clojars" "http://s3pository.herokuapp.com/clojars"
                    }}}