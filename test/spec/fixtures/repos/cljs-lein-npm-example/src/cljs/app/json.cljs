(ns app.json
  (:require
   [goog.net.XhrIo :as xhr]))

(defn fetch-json [uri cb]
  (xhr/send uri (fn [e] (-> e .-target .getResponseJson js->clj cb))))
