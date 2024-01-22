// Ensures the polyfill is loaded before any modules that may fail without.
// Author: Terje Norderhaug <terje@in-progress.com>
// Date: August 2015
//
// Note: Will be compiled into target-dir not classpath subdirectory
// Hack emulating early parts of target-file in effect injecting a dependency

// Not currently used...

//     :foreign-libs [{:file "src/node/server/boot.js"
//                     :provides ["server.boot"] ;; use to also inject dependencies
//                     :requires ["goog"]}] ;; not really required so remove?

var path = require("path");
require(path.join(path.resolve("."),"server/lib","goog","bootstrap","nodejs.js"));
// require("./server/lib/goog/bootstrap/nodejs.js");
goog.addDependency("../domina/support.js", ["domina.support"], ["server.compat"]);
goog.provide("server.boot");
require(path.join(path.resolve("."),"server", "main.js"));
// require("./server/main.js");
