# Changelog

## [Unreleased]

* Improve error message for malformed `project.clj` files. ([#208](https://github.com/heroku/heroku-buildpack-clojure/pull/208))


## [v93] - 2026-01-27

* Install Leiningen from upstream repository instead of using a vendored script. ([#201](https://github.com/heroku/heroku-buildpack-clojure/pull/201))
* Remove Leiningen `1.x` support. ([#201](https://github.com/heroku/heroku-buildpack-clojure/pull/201))
* Remove automatic Node.js installation. Users must explicitly add the Node.js buildpack if their project requires Node.js or npm. ([#192](https://github.com/heroku/heroku-buildpack-clojure/pull/192))
* Suppress curl output during leiningen installation to reduce build log noise and improve testability. ([#188](https://github.com/heroku/heroku-buildpack-clojure/pull/188))
* Replace `apt-get` `rlwrap` installation with shim. ([#187](https://github.com/heroku/heroku-buildpack-clojure/pull/187))
* Buildpack output slightly changed. If you match against the buildpack output, verify your matching still works and adjust if necessary. ([#191](https://github.com/heroku/heroku-buildpack-clojure/pull/191))
* Upgrade Clojure CLI to `1.12.4.1597` ([#206](https://github.com/heroku/heroku-buildpack-clojure/pull/206))
* Upgrade default Leiningen to `2.12.0` ([#204](https://github.com/heroku/heroku-buildpack-clojure/pull/204))

## [v92] - 2025-09-11

* Add metrics infrastructure and collection. ([#178](https://github.com/heroku/heroku-buildpack-clojure/pull/178))
* Remove `heroku-20` support. ([#168](https://github.com/heroku/heroku-buildpack-clojure/pull/168))

## [v91] - 2023-09-19

* Drop dependency on Node.js version resolver service, `nodebin.herokai.com`. ([#143](https://github.com/heroku/heroku-buildpack-clojure/pull/143))
* Remove `heroku-18` support. ([#140](https://github.com/heroku/heroku-buildpack-clojure/pull/140))

## [v90] - 2022-07-06

* Fix compatibility with the `heroku/google-chrome` buildpack. ([#122](https://github.com/heroku/heroku-buildpack-clojure/pull/122))

## [v89] - 2022-06-14

* Adjust `curl` retry and connection timeout handling.
* Vendor `buildpack-stdlib` rather than downloading it at build time.
* Switch to the recommended regional S3 domain instead of the global one.

## [v88] - 2022-06-07

* Add `heroku-22` support.
* Remove `heroku-16` testing.

## [v87] - 2021-02-23

* Enable `heroku-20` testing. ([#96](https://github.com/heroku/heroku-buildpack-clojure/pull/96))

## [v86] - 2020-10-12

* Update tests. ([#88](https://github.com/heroku/heroku-buildpack-clojure/pull/88))

## [v85] - 2020-06-24

* Rename `BUILD_CONFIG_WHITELIST` to `BUILD_CONFIG_ALLOWLIST`. ([#79](https://github.com/heroku/heroku-buildpack-clojure/pull/79))

## [v84] - 2019-08-12

* Update default `lein` to `2.9.1`. ([#70](https://github.com/heroku/heroku-buildpack-clojure/pull/70))

## [v83] - 2019-02-04

* Update default `lein` to `2.8.3`. ([#61](https://github.com/heroku/heroku-buildpack-clojure/pull/61))
* Install `rlwrap` from apt package. ([#58](https://github.com/heroku/heroku-buildpack-clojure/pull/58))
* Install `clj` CLI tools. ([#61](https://github.com/heroku/heroku-buildpack-clojure/pull/61))

## [v79] - 2018-04-23

* Update `jvm-common` URL to use buildpack-registry. ([#57](https://github.com/heroku/heroku-buildpack-clojure/pull/57))

## [v78] - 2017-12-15

* Use `nodebin` to download Node.js instead of `s3pository`. ([#55](https://github.com/heroku/heroku-buildpack-clojure/pull/55))

## [v75] - 2016-02-08

* Upgrade to Leiningen `2.6.1`.

## [v74] - 2016-02-05

* Upgrade to Leiningen `2.6.0`. ([#42](https://github.com/heroku/heroku-buildpack-clojure/pull/42))

## [v69] - 2015-08-10

* Fix a regression in launching applications with `lein`. The old S3 bucket was being used instead of the new one.

## [v68] - 2015-08-10

* Upgrade to Leiningen `2.5.2`.
* Move all binaries to `lang-jvm` bucket.

## [v67] - 2015-06-16

* Add a guard clause for default process types.

## [v65] - 2015-01-12

* Upgrade JVM common package to `v11`. ([#36](https://github.com/heroku/heroku-buildpack-clojure/pull/36))
* Upgrade to Leiningen `2.5.1`.
* Add support for configuration variables during compile phase. ([#30](https://github.com/heroku/heroku-buildpack-clojure/pull/30))

## [v63] - 2014-12-05

* Upgrade to Leiningen `2.5.0`. ([#39](https://github.com/heroku/heroku-buildpack-clojure/pull/39))

## [v36] - 2012-09-18

* Alias `lein repl` to `lein standalone-repl` to work around firewall issues. See https://github.com/heroku/heroku-buildpack-clojure/issues/14

## [v7] - 2012-08-27

* Use Leiningen `2.0.0-preview10` for `2.x` compiles.
* Fix a bug where dependencies would be fetched at dyno launch time.

## [v6] - 2012-08-16

* Use Leiningen `2.0.0-preview8` for `2.x` compiles.

## [v5] - 2012-08-09

* Run [clean-m2](https://github.com/technomancy/lein-clean-m2) task to avoid unbounded cache growth.
* Use S3 mirror with Leiningen `2`.
* Run `bin/build` if present instead of default `lein` invocation.
* Support Leiningen `1.x` and `2.x` in the same branch. Set `:min-lein-version "2.0.0"` to trigger Leiningen `2`.

## [v4] - 2012-03-27

* Update to Leiningen `1.7.1`.
* Fix a bug where the cache wouldn't be used.

## [v3] - 2012-03-05

* Don't let Clojure versions from plugins interfere with Leiningen.

## [v2] - 2012-02-10

* Use Leiningen `1.7.0`.
* Fix a bug where `JAVA_OPTS` were not honored.
* Honor `:plugins`.

## [v1] - 2011-12-28

* Use Leiningen `1.6.2`.
* Support Leiningen's `trampoline` task for reduced memory usage.
* Allow task performed upon compilation to be customized by setting `LEIN_BUILD_TASK`.
* Allow `LEIN_NO_DEV` to be disabled so plugins may be used.

## [v0] - 2011-05-23

* Initial release.
* Use Leiningen `1.5.2`.

[unreleased]: https://github.com/heroku/heroku-buildpack-clojure/compare/v93...main
[v93]: https://github.com/heroku/heroku-buildpack-clojure/compare/v92...v93
[v92]: https://github.com/heroku/heroku-buildpack-clojure/compare/v91...v92
[v91]: https://github.com/heroku/heroku-buildpack-clojure/compare/v90...v91
[v90]: https://github.com/heroku/heroku-buildpack-clojure/compare/v89...v90
[v89]: https://github.com/heroku/heroku-buildpack-clojure/compare/v88...v89
[v88]: https://github.com/heroku/heroku-buildpack-clojure/compare/v87...v88
[v87]: https://github.com/heroku/heroku-buildpack-clojure/compare/v86...v87
[v86]: https://github.com/heroku/heroku-buildpack-clojure/compare/v85...v86
[v85]: https://github.com/heroku/heroku-buildpack-clojure/compare/v84...v85
[v84]: https://github.com/heroku/heroku-buildpack-clojure/compare/v83...v84
[v83]: https://github.com/heroku/heroku-buildpack-clojure/compare/v82...v83
[v82]: https://github.com/heroku/heroku-buildpack-clojure/compare/v81...v82
[v81]: https://github.com/heroku/heroku-buildpack-clojure/compare/v80...v81
[v80]: https://github.com/heroku/heroku-buildpack-clojure/compare/v79...v80
[v79]: https://github.com/heroku/heroku-buildpack-clojure/compare/v78...v79
[v78]: https://github.com/heroku/heroku-buildpack-clojure/compare/v77...v78
[v77]: https://github.com/heroku/heroku-buildpack-clojure/compare/v76...v77
[v76]: https://github.com/heroku/heroku-buildpack-clojure/compare/v75...v76
[v75]: https://github.com/heroku/heroku-buildpack-clojure/compare/v74...v75
[v74]: https://github.com/heroku/heroku-buildpack-clojure/compare/v73...v74
[v73]: https://github.com/heroku/heroku-buildpack-clojure/compare/v72...v73
[v72]: https://github.com/heroku/heroku-buildpack-clojure/compare/v71...v72
[v71]: https://github.com/heroku/heroku-buildpack-clojure/compare/v70...v71
[v70]: https://github.com/heroku/heroku-buildpack-clojure/compare/v68...v70
[v68]: https://github.com/heroku/heroku-buildpack-clojure/compare/v67...v68
[v67]: https://github.com/heroku/heroku-buildpack-clojure/compare/v66...v67
[v66]: https://github.com/heroku/heroku-buildpack-clojure/compare/v65...v66
[v65]: https://github.com/heroku/heroku-buildpack-clojure/compare/v64...v65
[v64]: https://github.com/heroku/heroku-buildpack-clojure/compare/v63...v64
[v63]: https://github.com/heroku/heroku-buildpack-clojure/compare/v7...v63
[v36]: https://github.com/heroku/heroku-buildpack-clojure/compare/v7...v36
[v7]: https://github.com/heroku/heroku-buildpack-clojure/compare/v6...v7
[v6]: https://github.com/heroku/heroku-buildpack-clojure/compare/v5...v6
[v5]: https://github.com/heroku/heroku-buildpack-clojure/compare/v4...v5
[v4]: https://github.com/heroku/heroku-buildpack-clojure/compare/v3...v4
[v3]: https://github.com/heroku/heroku-buildpack-clojure/compare/v2...v3
[v2]: https://github.com/heroku/heroku-buildpack-clojure/compare/v1...v2
[v1]: https://github.com/heroku/heroku-buildpack-clojure/compare/37388f1...v1
[v0]: https://github.com/heroku/heroku-buildpack-clojure/commits/v1
