(ns app.start
  (:require [app.core :as app]))

(defn ^:export main []
  (app/activate))

(set! js/main-cljs-fn main)
