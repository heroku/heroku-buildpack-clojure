(ns app.core
  (:require-macros
   [cljs.core.async.macros :refer [go go-loop]])
  (:require
   [cljs.core.async :as async :refer [chan close! timeout put!]]
   [goog.dom :as dom]
   [goog.events :as events]
   [reagent.core :as reagent :refer [atom]]
   [app.jokes :refer [fresh-jokes]]
   [app.views :refer [jokes-view jokes-page html5]]))

(def scripts [{:src "/js/out/app.js"}
              "main_cljs_fn()"])

(def jokes-chan
  (memoize #(fresh-jokes 12 2)))

(defn static-page []
  (let [out (chan 1)]
    (go
      (put! out
            (-> (<! (jokes-chan))
                (jokes-page :scripts scripts)
                (reagent/render-to-string)
                (html5))))
    out))

(defn activate []
  (let [el (dom/getElement "jokes")
        joke-num 12
        buf-size 3
        jokes-buf (fresh-jokes joke-num buf-size :concur (* joke-num buf-size))
        jokes (atom nil)
        user-action (chan)]
    (events/listen el events/EventType.CLICK
                   (partial put! user-action))
    (go-loop [initialized false]
      (when (some? (<! user-action))
        (reset! jokes (<! jokes-buf))
        (when-not initialized
          (reagent/render [#(jokes-view @jokes)] el))
        (recur true)))))
