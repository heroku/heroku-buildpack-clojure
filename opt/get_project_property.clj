#!/usr/bin/env -S clojure -M

;; This script extracts properties from project.clj files.
;;
;; This leverages Clojure's homoiconicity (code is data) to parse project.clj as a data
;; structure. Since project.clj is valid Clojure code, we can use read-string to parse it
;; and extract properties reliably.
;;
;; This is much more robust than grep because it:
;; - Handles multi-line values correctly
;; - Respects Clojure syntax (strings, nested structures, comments)
;; - Won't be fooled by property names appearing in comments or strings
;; - Properly handles quoted strings and escape sequences

(when (< (count *command-line-args*) 2)
  (binding [*out* *err*]
    (println "Usage: get_project_property.clj <project.clj> <property-name> [<nested-key>...]"))
  (System/exit 1))

(defn get-project-property [file-path & property-path]
  (let [project-data (read-string (slurp file-path))
        properties (apply hash-map (drop 3 project-data))
        key-path (map keyword property-path)]
    (get-in properties key-path)))

(let [file-path (first *command-line-args*)
      property-path (rest *command-line-args*)
      property-value (apply get-project-property file-path property-path)]
  (println (or property-value "")))
