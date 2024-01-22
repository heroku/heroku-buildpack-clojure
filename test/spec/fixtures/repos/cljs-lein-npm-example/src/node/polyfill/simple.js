// goog.provide("polyfill.simple");

// When using :simple optimization some polyfill needs to be loaded
// before modules that would fail without.
//
// Force early injection into executable
// by loading this as :foreign-libs in the project file, e.g.:
//
// :optimizations :simple
// :foreign-libs [{:file "src/node/polyfill/simple.js"
//                 :provides ["polyfill.simple"]}]
//
// Don't use :libs as it unfortunately injects late in :simple executables.
// Same holds for using :require from clojurescript.

if (typeof React == 'undefined') {
  // React = require("react"); // maybe compat can set js/React instead?
  global["React"] = require("react"); // avoid compiler err redefine constant
}

// Stand-ins redefined elsewhere... for hickory.core.cljs
function Node() {};
Node.ELEMENT_NODE = 1;
Node.ATTRIBUTE_NODE = 2;
Node.TEXT_NODE = 3;
Node.CDATA_SECTION_NODE = 4;
Node.ENTITY_REFERENCE_NODE = 5;
Node.ENTITY_NODE = 6;
Node.PROCESSING_INSTRUCTION_NODE = 7;
Node.COMMENT_NODE = 8;
Node.DOCUMENT_NODE = 9;
Node.DOCUMENT_TYPE_NODE = 10;
Node.DOCUMENT_FRAGMENT_NODE = 11;
Node.NOTATION_NODE = 12;

function NodeList() {};
NodeList.prototype = {
    length:0,
    item: function (index) {
        return this[index] || null;
    }
}
