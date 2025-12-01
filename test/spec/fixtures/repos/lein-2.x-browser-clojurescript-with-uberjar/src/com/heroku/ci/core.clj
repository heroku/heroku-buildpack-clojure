(ns com.heroku.ci.core
  (:require [compojure.core :refer [defroutes GET]]
            [compojure.route :as route]
            [ring.adapter.jetty :refer [run-jetty]]
            [ring.middleware.defaults :refer [wrap-defaults api-defaults]]
            [ring.util.response :as response])
  (:gen-class))

(defroutes app-routes
  (GET "/" [] (-> (response/resource-response "public/app.js")
                  (response/content-type "application/javascript")))
  (route/not-found "Not Found"))

(def app
  (wrap-defaults app-routes api-defaults))

(defn -main []
  (let [port (Integer/parseInt (System/getenv "PORT"))]
    (run-jetty app {:port port :join? false})))
