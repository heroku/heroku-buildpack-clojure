(ns app.views
  (:require
   [kioo.reagent :refer [html-content content append after set-attr do->
                         substitute listen unwrap]]
   [kioo.core :refer [handle-wrapper]]
   [reagent.core :as reagent :refer [atom]]
   [goog.string :as gstring])
  (:require-macros
   [kioo.reagent :refer [defsnippet deftemplate snippet]]))

;; Showcasing combining different ways to generate the markup for the page:
;; 1. Hiccup-style templating with elements as inline clojure vectors;
;; 2. Kioo (enlive style) injecting transformations into external template;
;;    The template file is in the resources directory.

(defn jokes-view-1 [jokes]
  [:div.row
   (for [joke jokes]
     ^{:key (gstring/hashCode joke)}
     [:div.joke-card.col-xs-12.col-sm-6.col-md-4.col-lg-3
      [:div.well
       [:div.joke joke]]])])

(defsnippet joke-card "template.html" [:main :.joke-card]
  [joke]
  {[:.joke] (content joke) })

(defsnippet jokes-view-2 "template.html" [:main :.row]
  [jokes]
  {[:.joke-card] (substitute (map joke-card jokes)) })

;; Use either of the jokes-view-* templates from above:

(def jokes-view jokes-view-2)

;; Template for the html page:

(defsnippet jokes-page "template.html" [:html]
  [jokes & {:keys [scripts]}]
  {[:main] (content [jokes-view jokes])
   [:body] (append [:div (for [src scripts]
                           ^{:key (gstring/hashCode (pr-str src))}
                           [:script src])]) })

(defn html5 [content]
  (str "<!DOCTYPE html>\n" content))

(defn test-views []
  (html5 (jokes-page ["Chuck Norris eats parentheses for breakfast"])))
