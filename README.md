![clojure](https://raw.githubusercontent.com/heroku/buildpacks/refs/heads/main/assets/images/buildpack-banner-clojure.png)

# Heroku Buildpack: Clojure (Leiningen) [![CI](https://github.com/heroku/heroku-buildpack-clojure/actions/workflows/ci.yml/badge.svg)](https://github.com/heroku/heroku-buildpack-clojure/actions/workflows/ci.yml)

This is the official [Heroku buildpack](https://devcenter.heroku.com/articles/buildpacks) for apps that use [Leiningen](https://leiningen.org/) as their build tool. It's used to build [Clojure](https://clojure.org/) applications.

If you're using a different JVM build tool, use the appropriate buildpack:
* [Java buildpack](https://github.com/heroku/heroku-buildpack-java) for [Maven](https://maven.apache.org/) projects (including [clojure-maven-plugin](https://github.com/talios/clojure-maven-plugin))
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
  - [Uberjar Deployment](#uberjar-deployment)
  - [Leiningen at Runtime](#leiningen-at-runtime)
  - [Custom Build Script](#custom-build-script)
- [Documentation](#documentation)

## Supported Leiningen Versions

This buildpack officially supports Leiningen `2.x`. Legacy support is available for Leiningen `1.7.1`, though using Leiningen 2.x is highly recommended. The buildpack will automatically use Leiningen 2.x if your `project.clj` contains `:min-lein-version "2.0.0"` or higher.

## Getting Started

See the [Getting Started with Clojure on Heroku](https://devcenter.heroku.com/articles/getting-started-with-clojure) tutorial.

## Application Requirements

Your app requires a `project.clj` file in the root directory. The buildpack will detect your application as Clojure if this file is present.

## Configuration

### OpenJDK Version

Specify an OpenJDK version by creating a `system.properties` file in the root of your project directory and setting the `java.runtime.version` property. See the [Java Support article](https://devcenter.heroku.com/articles/java-support#supported-java-versions) for available versions and configuration instructions.

### Leiningen Version

The buildpack will use Leiningen 2.x if your `project.clj` contains `:min-lein-version "2.0.0"` or higher. Otherwise, it defaults to Leiningen 1.7.1.

You can also provide your own `bin/lein` script in your repository to use a specific Leiningen version.

### Buildpack Configuration

Configure the buildpack by setting environment variables:

| Environment Variable | Description | Default |
|---------------------|-------------|---------|
| `BUILD_CONFIG_ALLOWLIST` | Space-delimited list of config var names to expose during compilation | (none) |

**Note:** By default, config vars set with `heroku config:set` (except `LEIN_USERNAME`, `LEIN_PASSWORD`, and `LEIN_PASSPHRASE`) are not visible during compilation to ensure consistent builds. Use `BUILD_CONFIG_ALLOWLIST` with caution, as changing config values won't trigger rebuilds, which can lead to broken builds that go unnoticed until the next push.

### Uberjar Deployment

If your `project.clj` contains an `:uberjar-name` setting, the buildpack will run `lein uberjar` during deployment. This is the recommended approach for production deployments.

Your `Procfile` should invoke Java directly rather than using Leiningen:

```
web: java -cp target/myproject-standalone.jar clojure.main -m myproject.web
```

If your main namespace has a `:gen-class`, you can use it as the entry point. Otherwise, use `clojure.main` with the `-m` flag as shown above.

You can use the `:uberjar` profile in your `project.clj` to apply settings only during builds, such as AOT compilation:

```clojure
:profiles {:uberjar {:main myproject.web, :aot :all}}
```

**Important:** If you use Leiningen features that affect runtime (`:jvm-opts`, native dependencies, `:java-agents`), ensure your `Procfile` includes these settings in the `java` invocation, or use Leiningen at runtime instead.

### Leiningen at Runtime

Instead of using an uberjar, you can have Leiningen launch your application at runtime. Use the `trampoline` and `with-profile` tasks to ensure Leiningen exits after calculating the classpath and to omit development profiles:

```
web: lein with-profile production trampoline run -m myapp.web
```

**Note:** This approach adds about 10 MB to your slug size and 1-2 seconds to boot time. Leiningen will be downloaded on-demand if needed in `heroku run` sessions.

### Custom Build Script

If you need custom build behavior, you can provide an executable `bin/build` script in your repository. The buildpack will run this script instead of `compile` or `uberjar` after setting up Leiningen.

## Documentation

For more information about using Clojure on Heroku, see these Dev Center articles:

* [Getting Started with Clojure on Heroku](https://devcenter.heroku.com/articles/getting-started-with-clojure)
* [Heroku Clojure Support](https://devcenter.heroku.com/articles/clojure-support)
* [Building a Database-Backed Clojure Web Application](https://devcenter.heroku.com/articles/clojure-web-application)
* [Database Connection Pooling with Clojure](https://devcenter.heroku.com/articles/database-connection-pooling-with-clojure)
* [Live-Debugging Remote Clojure Apps with Drawbridge](https://devcenter.heroku.com/articles/debugging-clojure)
* [WebSockets on Heroku with Clojure and Immutant](https://devcenter.heroku.com/articles/using-websockets-on-heroku-with-clojure-and-immutant)
* [Queuing in Clojure with Langohr and RabbitMQ](https://devcenter.heroku.com/articles/queuing-in-clojure-with-langohr-and-rabbitmq)