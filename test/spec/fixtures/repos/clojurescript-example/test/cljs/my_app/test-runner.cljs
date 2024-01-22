(ns my_app.test-runner
  (:require
   [cljs.test :refer-macros [run-tests]]
   [my_app.core-test]))

(enable-console-print!)

(defn runner []
  (if (cljs.test/successful?
       (run-tests
        'my_app.core-test))
    0
    1))
