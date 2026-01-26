![clojure](https://raw.githubusercontent.com/heroku/buildpacks/refs/heads/main/assets/images/buildpack-banner-clojure.png)

# Heroku Buildpack: Clojure (Leiningen) [![CI](https://github.com/heroku/heroku-buildpack-clojure/actions/workflows/ci.yml/badge.svg)](https://github.com/heroku/heroku-buildpack-clojure/actions/workflows/ci.yml)

This is the official [Heroku buildpack](https://devcenter.heroku.com/articles/buildpacks) for apps that use [Leiningen](https://leiningen.org/) as their build tool. It's primarily used to build [Clojure](https://clojure.org/) applications.

If you're using a different JVM build tool, use the appropriate buildpack:
* [Java buildpack](https://github.com/heroku/heroku-buildpack-java) for [Maven](https://maven.apache.org/) projects
* [Gradle buildpack](https://github.com/heroku/heroku-buildpack-gradle) for [Gradle](https://gradle.org/) projects
* [Scala buildpack](https://github.com/heroku/heroku-buildpack-scala) for [sbt](https://www.scala-sbt.org/) projects

## Table of Contents

- [Supported Leiningen Versions](#supported-leiningen-versions)
- [Getting Started](#getting-started)
- [Application Requirements](#application-requirements)
- [Configuration](#configuration)
  - [OpenJDK Version](#openjdk-version)
  - [Leiningen Version](#leiningen-version)
  - [Buildpack Configuration](#buildpack-configuration)
- [Documentation](#documentation)

## Supported Leiningen Versions

This buildpack officially supports Leiningen `2.x`. Leiningen `1.x` is no longer supported.

## Getting Started

See the [Getting Started with Clojure on Heroku](https://devcenter.heroku.com/articles/getting-started-with-clojure) tutorial.

## Application Requirements

Your app requires a `project.clj` file in the root directory with `:min-lein-version "2.0.0"` or higher. It's recommended to also configure `:uberjar-name` in your `project.clj`.

## Configuration

### OpenJDK Version

Specify an OpenJDK version by creating a `system.properties` file in the root of your project directory and setting the `java.runtime.version` property. See the [Java Support article](https://devcenter.heroku.com/articles/java-support#supported-java-versions) for available versions and configuration instructions.

### Leiningen Version

The buildpack uses Leiningen `2.12.0` by default for projects that specify `:min-lein-version "2.0.0"` or higher in their `project.clj`.

To use a specific Leiningen version, you can include a `bin/lein` script in your repository. The buildpack will detect and use this script instead of the default Leiningen installation.

### Buildpack Configuration

Configure the buildpack by setting environment variables:

| Environment Variable | Description | Default |
|---------------------|-------------|---------|
| `LEIN_BUILD_TASK` | Leiningen task to execute | `uberjar` (if `:uberjar-name` is set) or `with-profile production compile :all` |
| `LEIN_INCLUDE_IN_SLUG` | Include Leiningen in the slug for runtime use | `no` |
| `CLOJURE_CLI_VERSION` | Clojure CLI tools version | `1.12.4.1582` |

You can also override the default build behavior by including a `bin/build` script in your repository. The buildpack will execute this script instead of the default build command.

## Documentation

For more information about using Clojure on Heroku, see the [Clojure Support](https://devcenter.heroku.com/categories/clojure-support) documentation on Dev Center.
