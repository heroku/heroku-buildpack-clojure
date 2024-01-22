;; Entry point for node apps that needs the polyfill to be loaded
;; before modules are loaded. Require from elsewhere to ensure
;; boot.js is included in the build.
;;
;; Can be avoided by careful dependence management to ensure that polyfill is
;; loaded before modules that needs it. See the generated cljs_deps.js
;; Polyfill should ideally be at the beginning of the dependency list of main:
;; goog.addDependency("../server/core.js", ['server.core'], ['polyfill...
;; * Place polyfill early on the require list.
;; * Require this module [polyfill.boot] to ensure it is built and included.
;; * May only work when :optimization is :none due to the paths.

(when false ;; doesn't seem to be needed anymore
  (js/require "../goog/bootstrap/nodejs.js") ; dependency support

;; (These could possibly be resolved by adding a dependency to a core cljs module)
  (.addDependency js/goog "../domina/support.js" #js ["domina.support"] #js ["polyfill.compat"])
  (.addDependency js/goog "../hickory/core.js" #js ["hickory.core"] #js ["polyfill.compat"])

;; require(path.join(path.resolve("."),"..","main.js"));
;; (.require (.join js/path (.resolve js/path ".") ".." "main.js"))
  (js/require "../main.js")
)

;; ns is deliberately last to avoid requiring cljs.core:
(ns polyfill.boot)
