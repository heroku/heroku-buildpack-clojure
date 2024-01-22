(ns demo.messaging
  (:require [immutant.messaging :as msg]))

(defn listener
  "A simple message listener"
  [m]
  (println "listener received" (pr-str m)))

(defn -main [& _]

  ;; msg/queue creates a queue in HornetQ if it does not already exist
  ;; returns a reference to the queue
  (msg/queue "my-queue")

  ;; registers a fn to be called each time a message comes in
  (msg/listen (msg/queue "my-queue") listener)

  ;; sends 10 messages to the queue
  (dotimes [n 10]
    (msg/publish (msg/queue "my-queue") {:message n}))

  ;; default encoding is :edn. Other options are: :edn, :fressian, :json, :none
  ;; :json requires cheshire, :fressian requires data.fressian
  (msg/publish (msg/queue "my-queue") {:message :hi} :encoding :json)

  ;; using synchronous messaging (request/respond)
  (msg/queue "sync-queue")

  ;; registers a fn as a responder - a listener who's return value
  ;; is sent to the requester
  (msg/respond (msg/queue "sync-queue") inc)

  (dotimes [n 5]
    ;; request returns a j.u.c.Future
    (println "response is:"
      @(msg/request (msg/queue "sync-queue") n)))
  )
