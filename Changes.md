# History of Changes

## Version 63

* Upgrade to Leiningen 2.5.0

## Version 36 - 2012-09-18

* Alias `lein repl` to `lein standalone-repl` to work around firewall issues.
  See https://github.com/heroku/heroku-buildpack-clojure/issues/14

## Version 7 - 2012-08-27

* Use Leiningen 2.0.0-preview10 for 2.x compiles.
* Fix a bug where dependencies would be fetched at dyno launch time.

## Version 6 - 2012-08-16

* Use Leiningen 2.0.0-preview8 for 2.x compiles.

## Version 5 - 2012-08-09

* Run [clean-m2](https://github.com/technomancy/lein-clean-m2) task to avoid unbounded cache growth.
* Use S3 mirror with Leiningen 2.
* Run bin/build if present instead of default lein invocation.
* Support Leiningen 1.x and 2.x in the same branch.
  Set :min-lein-version "2.0.0" to trigger Leiningen 2.

## Version 4 - 2012-03-27

* Update to Leiningen 1.7.1.
* Fix a bug where the cache wouldn't be used.

## Version 3 - 2012-03-05

* Don't let Clojure versions from plugins interfere with Leiningen.

## Version 2 - 2012-02-10

* Use Leiningen 1.7.0
* Fix a bug where JAVA_OPTS were not honored.
* Honor :plugins.

## Version 1 - 2011-12-28

* Use Leiningen 1.6.2
* Support Leiningen's `trampoline` task for reduced memory usage.
* Allow task performed upon compilation to be customized by setting LEIN_BUILD_TASK.
* Allow LEIN_NO_DEV to be disabled so plugins may be used.

## Version 0 - 2011-05-23

* Initial release
* Use Leiningen 1.5.2
