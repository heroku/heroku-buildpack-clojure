# Clojure Buildpack Changelog

## v86

* Update tests

## v85

* Rename `BUILD_CONFIG_WHITELIST` to `BUILD_CONFIG_ALLOWLIST`

## v84

* Update default lein to 2.9.1

## v83

* Update default lein to 2.8.3
* Install rlwrap from apt package
* Install clj CLI tools

## v79

* Update jvm-common URL to use buildpack-registry

## v78

* Use nodebin to download Node.js instead of s3pository

## v75

* Upgraded to Leiningen 2.6.1

## v74

* Upgraded to Leiningen 2.6.0

## v69

* Fixed a regression in launching applications with `lein`. The old S3 bucket was
being used instead of the new one.

## v68

Upgrade to Leiningen 2.5.2

* Upgrade to Leiningen 2.5.2
* Moved all binaries to lang-jvm bucket

## v67

* Added a guard clause for default process types

## v65

* Upgrade JVM common package to v11
* Upgrade to Leiningen 2.5.1
* Added support for configuration variables during compile phase

## v63

* Upgrade to Leiningen 2.5.0

## v36 - 2012-09-18

* Alias `lein repl` to `lein standalone-repl` to work around firewall issues.
  See https://github.com/heroku/heroku-buildpack-clojure/issues/14

## v7 - 2012-08-27

* Use Leiningen 2.0.0-preview10 for 2.x compiles.
* Fix a bug where dependencies would be fetched at dyno launch time.

## v6 - 2012-08-16

* Use Leiningen 2.0.0-preview8 for 2.x compiles.

## v5 - 2012-08-09

* Run [clean-m2](https://github.com/technomancy/lein-clean-m2) task to avoid unbounded cache growth.
* Use S3 mirror with Leiningen 2.
* Run bin/build if present instead of default lein invocation.
* Support Leiningen 1.x and 2.x in the same branch.
  Set :min-lein-version "2.0.0" to trigger Leiningen 2.

## v4 - 2012-03-27

* Update to Leiningen 1.7.1.
* Fix a bug where the cache wouldn't be used.

## v3 - 2012-03-05

* Don't let Clojure versions from plugins interfere with Leiningen.

## v2 - 2012-02-10

* Use Leiningen 1.7.0
* Fix a bug where JAVA_OPTS were not honored.
* Honor :plugins.

## v1 - 2011-12-28

* Use Leiningen 1.6.2
* Support Leiningen's `trampoline` task for reduced memory usage.
* Allow task performed upon compilation to be customized by setting LEIN_BUILD_TASK.
* Allow LEIN_NO_DEV to be disabled so plugins may be used.

## v0 - 2011-05-23

* Initial release
* Use Leiningen 1.5.2
