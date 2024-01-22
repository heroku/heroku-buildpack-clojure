(ns polyfill.compat
  (:require
   [cljs.nodejs :as nodejs]
   [polyfill.simple]))

"
Load before any module that depends on basic browser context.
You may have to use (.require js/goog) before the ns delcaration as
the cljs compiler results in arbitrary order of required modules.
goog.require is supposed to be synchronous when used under node,
(https://github.com/google/closure-library/wiki/Using-Closure-Library-with-node.js)
but that doesn't seem to be the case, which may require additional concerns.
"

(enable-console-print!)

;; http://stackoverflow.com/questions/8554745/implementing-an-ajax-call-in-clojurescript
;; http://stackoverflow.com/questions/21839156/node-js-javascript-html-xmlhttprequest-cannot-load

;; Required for goog.net.XhrIo on node:

(def xhr (nodejs/require "xmlhttprequest"))
(when xhr
  (set! js/XMLHttpRequest (.-XMLHttpRequest xhr)))

;; Reagent uses js/React:

(def react (nodejs/require "react"))
(when react
  (aset js/global "React" react)) ; work-arounds "constant React assigned a value more than once."

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DOM

;; https://github.com/google/closure-library/wiki/Using-Closure-Library-with-node.js
;; "any libraries in Closure Library that use the DOM will not work on NodeJS"
;; https://www.npmjs.com/package/jsdom
;; Taking that as a challenge!

;; [xmldom "0.1.19"] seems to do the job (mostly):
;; https://www.npmjs.com/package/xmldom

(def xmldom (nodejs/require "xmldom"))
(def dom-parser (.-DOMParser xmldom))
(def dom-serializer (.-XMLSerializer xmldom))
(def xmldom-implementation (.-DOMImplementation xmldom))

(def dom (nodejs/require "xmldom/dom"))
(def DOMImplementation (.-DOMImplementation dom))

(def sax (nodejs/require "xmldom/sax"))

(def xhtml
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
   <!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\"
    \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">
   <html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" >
    <head>
      <title>untitled</title>
    </head>
    <body>
      <!-- <p></p> -->
    </body>
  </html>")

; (def doc (.parseFromString (new dom-parser) xhtml "application/xml"))

(defn default-html-markup [& [title]]
  (str "<html><head>" ; per spec, don't change markup
       (if title (str "<title>" title "</title>"))
       "</head><body></body></html>"))

(defn html-from-string [& [html]]
  (let [parser (new dom-parser)
        markup (or html (default-html-markup))
        frag (.parseFromString parser markup "text/html")]
    frag))

(def doc (html-from-string (default-html-markup "untitled")))

(when-not (aget js/global "document")
  ; (set! js/document doc)
  (aset js/global "document" doc)) ; avoid compiler reset constant error

(when-not (try goog.global.document (catch js/Error e false))
  (set! goog.global.document doc))

(def dom-implementation (.-implementation doc))

;; Can't yet set window before loading react.js as it uses it to test for canUseDom
;; wait until DOM implementaiton is more complete?
;; (set! js/window js/global)

;; Still element.innerHTML need to be supported:
;; see https://github.com/jindw/xmldom/blob/f053be7ceb9b1ddcff93c4b36c92dadb4d589986/dom.js
;; Challenge like getting past this in Domina:
;; https://github.com/levand/domina/blob/master/src/cljs/domina/support.cljs
;; in particular Element.prototype in xmldom/dom
;; Maybe create an observer on the setter?
;; http://stackoverflow.com/questions/20388229/is-using-javascript-setters-and-getter-properties-to-watch-for-changes-a-bad-ide#20388491

; (set! js/Element.prototype. )

(defn observe-object [obj observer]
  (.observe js/Object obj observer))

(defn observer [changes]
  (println "CHANGES:" (pr-str changes)))

;; turns out this is overkill:
;; (observe-object div observer)
;;
;; Instead use __defineGetter__ and __defineSetter__ on the element:
;; or Object.defineProperty ??

(defn as-getter [f]
  (fn [](this-as this (f this))))

(defn defget [obj prop f]
  (:pre [(string? prop)])
  (.__defineGetter__ obj prop (as-getter f)))

(defn as-setter [f]
  (fn [val](this-as this (f this val))))

(defn defset [obj prop f]
  (:pre [(string? prop)])
  (.__defineSetter__ obj prop (as-setter f)))

(def frag (.parseFromString (new dom-parser) "<p>abc</p><div>def</div>" "text/html"))

(defn clear-children! [node]
  (while (.hasChildNodes node)
    (.removeChild node (.-firstChild node)))
  node)

(defn append-nodes! [node nodes]
  {:pre [(not (nil? nodes))]}
  (let [n (aget nodes "length")]
    (doseq [i (range n)]
      (.appendChild node
                    (if-let [doc (.-ownerDocument node)]
                      (.importNode doc (.item nodes i) true)
                      (.cloneNode (.item nodes i) true))))
    node))

(defn node-content-string [node]
  (let [children (.-childNodes node)
        n (aget children "length")
        serializer (new dom-serializer)]
    (->>
     (map #(.serializeToString serializer (.item children %)) (range n))
     (apply str))))

(def div (.createElement js/document "div"))

(defn prototype-of [instance] ; works
  (.getPrototypeOf js/Object instance))

(defn type-prototype [type] ;; ## rename to type-prototype
  (.-prototype type))

(defn object-keys [obj]
  (.keys js/Object obj))

(defn defproperty [prototype prop-name {:as descriptor}]
  "deftype on a native level"
  (.defineProperty js/Object prototype prop-name (clj->js descriptor)))

(defn append-html [node html]
  (let [frag (html-from-string html)
        nodes (.-childNodes frag)]
    (append-nodes! node nodes)))

(defn set-inner-html [node html]
  {:pre [(not (nil? node)) (string? html)]}
  (clear-children! node)
  (append-html node html)
  node)

(defn get-inner-html [node]
  ; {:pre [(not (nil? node))]}
  (if-not (nil? node)
    (node-content-string node)))

;;;;;;;;;;;;;;;
;; PROTOTYPES

(def dom-implementation-prototype
  (type-prototype (.-DOMImplementation dom)))

(def element-prototype (prototype-of div)) ; fails on print, but still OK

; Non-standard and deprecated way of defining property:
; (defget element-prototype "innerHTML" get-inner-html)
; (defset element-prototype "innerHTML" set-inner-html)
;; Standard way:
(defproperty element-prototype "innerHTML"
  {:get (as-getter get-inner-html)
   :set (as-setter set-inner-html)})

;; redo in case node prototypes areB cached:

(def doc2 (.parseFromString (new dom-parser) xhtml "application/xml"))

(def node (.createElement js/document "main"))

;; (get-inner-html node)
;; (set-inner-html node "<p>hello</p>");

;;(def frag2 (html-from-string "<p>hello</p>"))
;;(def nodes2 (.-childNodes frag2))
;;;; (append-nodes! node nodes)
;;(def doc2 (.-ownerDocument frag2))
;;(def old (.item nodes2 1))
;;(def fresh (.importNode doc2 old true))
;;(.appendChild node fresh)

(defn proto [obj] ;; likely same as getPrototypeOf
  (.-__proto__ obj))

(defn prototype-instantiate [p]
  (let [inst (fn [])]
    (set! (.-prototype inst) p)
    (set! (.-__proto__ inst) p)
    inst))

(defn override-prototype [obj prototype & [type]]
  (set! (.-prototype obj)
        (merge
         (if type (type-prototype type) #{})
         prototype))
  (set! (.-__proto__ obj)
        (merge
         (if type (proto type) #{})
         prototype))
  obj)

(defn clone-merge ; rename to mutate-prototype or merge-prototype
  ;; ... use clone-merge for one with only create?
  "The object merged with the js prototype"
  [type prototype]
  ;; Object.assign is possibly the better choice but not yet in Node
  ;; ## need to validate that this actually mutate shared prototype
  ;; ## which may not be the case vs override-prototype
  ;; ## need to copy the merge into the original object?
  (let [combo (.create js/Object prototype (type-prototype type))]
    (override-prototype type (type-prototype combo))))

(defn prototype-constructor [p]
  (.-constructor p))

;; js/Node (used in Hickory)
;; Node.prototype in dom.js of xmldom:

(def document-prototype
  (prototype-of doc))

(def node-prototype ; apparently correct so dont change
  (-> document-prototype proto))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deftype Node [] Object)
(override-prototype Node node-prototype (aget js/global "Node"))
(set! js/Node Node)
;(set! js/Node
;      (clone-merge (or (aget js/global "Node") Node)
;                    node-prototype))

; for testing - from hickory
(defn extend-type-with-seqable
  [t]
  (extend-type t
    ISeqable
    (-seq [array] (array-seq array))))

;; (def doc2 (.parseFromString (new dom-parser) xhtml "application/xml"))
;; (extend-type-with-seqable Node)
;; (map identity (Node.))
;; Now even an existing document should be seqable:
;; (map identity doc2)
;; Yes! Works...

;; js/NodeList (used in hickory.core)

(def nodelist-prototype (prototype-of (.-childNodes doc)))

(deftype NodeList [] Object)
(override-prototype NodeList nodelist-prototype (aget js/global "NodeList"))
(set! js/NodeList NodeList)
;;(set! js/NodeList
;;      (clone-merge (if (= js/undefined (aget js/global "NodeList"))
;;                     NodeList
;;                    (aget js/global "NodeList"))
;;                    nodelist-prototype))

(extend-type-with-seqable js/NodeList) ; test

; (set! (.-innerHTML node) "<p>hello</p>")

;; .createHTMLDocument
;; createhtmldocument used in hickory
;; http://www.w3.org/TR/domcore/#dom-domimplementation-createhtmldocument

(def Document (prototype-constructor document-prototype))

(defn create-document []
  (Document.))

(defn create-html-document [implementation & [title]]
  ;; Per specification
  (let [html (default-html-markup title)
        doctype (.createDocumentType implementation "html")
        doc (.createDocument implementation "" nil)]
    (.appendChild doc (.importNode doc doctype))
    (append-html doc html)
    (aset doc "hasFeature" (fn [] true)) ; specify instead?
    doc))

;; consider specify instead
;; (specify (type dom-implementation)
;;   createHTMLDocument
(aset (proto dom-implementation) "createHTMLDocument"
      #(this-as this (create-html-document this %1)))

;;; TEST:

(def test-html "<link/><table></table>
<a href='/a' style='top:1px;float:left;opacity:.55;'>a</a><input type='checkbox'/>")

;; (set! (.-innerHTML node) test-html)


;; (set! (.-innerHTML div) test-html)

;;(assert (.-firstChild div))
;;(assert (.getElementsByTagName div "tbody"))

;; Still can be a problem that dependenices aren't required in order,
;; as js/document need to be defined before certain modules.

;; may have to run goog.nodeGlobalRequire per the goog bootstrap.js

; Soon we should be able to use jsdom instead for more comprehensive browser dom emulation:
; (def jsdom (nodejs/require "jsdom"))
; (set! js/document (jsdom/jsdom "<p></p>" #js {}))
