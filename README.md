# Heroku buildpack: Clojure [![CircleCI](https://circleci.com/gh/heroku/heroku-buildpack-clojure/tree/main.svg?style=shield)](https://circleci.com/gh/heroku/heroku-buildpack-clojure/tree/main)
![clojure](https://cloud.githubusercontent.com/assets/51578/13712844/d37ac78c-e793-11e5-9f0a-d033eb4f6f9f.png)

This is the official [Heroku buildpack](http://devcenter.heroku.com/articles/buildpack) for Clojure apps. It uses
[Leiningen](http://leiningen.org).

Note that you don't have to do anything special to use this buildpack
with Clojure apps on Heroku; it will be used by default for all
projects containing a project.clj file, though it may be an older
revision than what you're currently looking at.

## How it works

The buildpack will detect your app as Clojure if it has a
`project.clj` file in the root. If you use the
[clojure-maven-plugin](https://github.com/talios/clojure-maven-plugin),
[the standard Java buildpack](http://github.com/heroku/heroku-buildpack-java)
should work instead.

## Documentation

For more information about using Clojure and buildpacks on Heroku, see these Dev Center articles:

+ [Getting Started with Clojure on Heroku](https://devcenter.heroku.com/articles/getting-started-with-clojure)
+ [Heroku Clojure Support](https://devcenter.heroku.com/articles/clojure-support)
+ [Building a Database-Backed Clojure Web Application](https://devcenter.heroku.com/articles/clojure-web-application)
+ [Database Connection Pooling with Clojure](https://devcenter.heroku.com/articles/database-connection-pooling-with-clojure)
+ [Live-Debugging Remote Clojure Apps with Drawbridge](https://devcenter.heroku.com/articles/debugging-clojure)
+ [WebSockets on Heroku with Clojure and Immutant](https://devcenter.heroku.com/articles/using-websockets-on-heroku-with-clojure-and-immutant)
+ [Queuing in Clojure with Langohr and RabbitMQ](https://devcenter.heroku.com/articles/queuing-in-clojure-with-langohr-and-rabbitmq)

## Usage

Example usage for an app already stored in git:

```sh-session
$ tree
|-- Procfile
|-- project.clj
|-- README
`-- src
    `-- sample
        `-- core.clj

$ heroku create
...

$ git push heroku main
...
remote: -----> Fetching custom tar buildpack... done
remote: -----> Clojure (Leiningen 2) app detected
remote: -----> Installing OpenJDK 1.8...done
remote: -----> Installing Leiningen
remote:        Downloading: leiningen-2.5.2-standalone.jar
remote:        Writing: lein script
remote: -----> Building with Leiningen
remote:        Running: lein uberjar
remote:        Created /tmp/build_37f1ae84b9f8b63c3ddef2a4b691ef41/target/clojure-getting-started-1.0.0-SNAPSHOT.jar
remote:        Created /tmp/build_37f1ae84b9f8b63c3ddef2a4b691ef41/target/clojure-getting-started-standalone.jar
remote: -----> Discovering process types
remote:        Procfile declares types -> web
remote:
remote: -----> Compressing... done, 53.6MB
remote: -----> Launching... done, v5
remote:        https://gentle-water-6857.herokuapp.com/ deployed to Heroku
remote:
remote: Verifying deploy.... done.
```

## Configuration

Leiningen 1.7.1 will be used by default, but if you have
`:min-lein-version "2.0.0"` in project.clj (highly recommended) then
the latest Leiningen 2.x release will be used instead.

Your `Procfile` should declare what process types which make up your
app. Often in development Leiningen projects are launched using `lein
run -m my.project.namespace`, but this is not recommended in
production because it leaves Leiningen running in addition to your
project's process. It also uses profiles that are intended for
development, which can let test libraries and test configuration sneak
into production.

In order to ensure consistent builds, normally values set with `heroku
config:add ...` (other than `LEIN_USERNAME`, `LEIN_PASSWORD`, and
`LEIN_PASSPHRASE`) will not be visible at compile time. To expose more
to the compilation process, set a `BUILD_CONFIG_ALLOWLIST` config var
containing a space-delimited list of config var names. Note that this
can result in unpredictable behaviour since changing your app's config
does not result in a rebuild of your app. So it's easy to get into a
situation where your build is broken, but you don't notice it until
later when you push. For this reason it's recommended to take care
with this feature and always push after changing a allowlisted config
value.

### Uberjar

If your `project.clj` contains an `:uberjar-name` setting, then
`lein uberjar` will run during deploys. If you do this, your `Procfile`
entries should consist of just `java` invocations.

If your main namespace doesn't have a `:gen-class` then you can use
`clojure.main` as your entry point and indicate your app's main
namespace using the `-m` argument in your `Procfile`:

    web: java -cp target/myproject-standalone.jar clojure.main -m myproject.web

If you have custom settings you would like to only apply during build,
you can place them in an `:uberjar` profile. This can be useful to use
AOT-compiled classes in production but not during development where
they can cause reloading issues:

```clj
:profiles {:uberjar {:main myproject.web, :aot :all}}
```

If you need Leiningen in a `heroku run` session, it will be downloaded
on-demand.

Note that if you use Leiningen features which affect runtime like
`:jvm-opts`, extraction of native dependencies, or `:java-agents`,
then you'll need to do a little extra work to ensure your Procfile's
`java` invocation includes these things. In these cases it might be
simpler to use Leiningen at runtime instead.

### Leiningen at Runtime

Instead of putting a direct `java` invocation into your Procfile, you
can have Leiningen handle launching your app. If you do this, be sure
to use the `trampoline` and `with-profile` tasks. Trampolining will
cause Leiningen to calculate the classpath and code to run for your
project, then exit and execute your project's JVM, while
`with-profile` will omit development profiles:

    web: lein with-profile production trampoline run -m myapp.web

Including Leiningen in your slug will add about ten megabytes to its
size and will add a second or two of overhead to your app's boot time.

### Overriding build behavior

If neither of these options get you quite what you need, you can check
in your own executable `bin/build` script into your app's repo and it
will be run instead of `compile` or `uberjar` after setting up Leiningen.

## Leiningen Version

The buildpack will check for a `bin/lein` script in the repo, and run it instead
of the default `lein` command. This allows you to control the exact version of
Leiningen used to build the app.

## JDK Version

By default you will get OpenJDK 1.8. To use a different version, you
can commit a `system.properties` file to your app.

```sh-session
$ echo "java.runtime.version=1.7" > system.properties
$ git add system.properties
$ git commit -m "JDK 7"
```

## Hacking

To change this buildpack, fork it on GitHub. Push up changes to your
fork, then create a test app with `--buildpack YOUR_GITHUB_URL` and
push to it. If you already have an existing app you may use
`heroku config:add BUILDPACK_URL=YOUR_GITHUB_URL` instead.

For example, you could adapt it to generate a tarball at build time.

Open `bin/compile` in your editor, and replace the block labeled
"Calculate build command" with something like this:

```bash
echo "-----> Generating tar with Leiningen:"
echo "       Running: lein tar"
cd $BUILD_DIR
PATH=.lein/bin:/usr/local/bin:/usr/bin:/bin JAVA_OPTS="-Xmx500m -Duser.home=$BUILD_DIR" lein tar 2>&1 | sed -u 's/^/       /'
if [ "${PIPESTATUS[*]}" != "0 0" ]; then
    echo " !     Failed to create tar with Leiningen"
    exit 1
fi
```

Commit and push the changes to your buildpack to your GitHub fork,
then push your sample app to Heroku to test. The output should include:

    -----> Generating tar with Leiningen:

If it's something other users would find useful, pull requests are welcome.

## Run Tests Locally

Tests can be run and debugged locally by using the [Circle CI CLI](https://circleci.com/docs/2.0/local-cli/).

For example, to run [Hatchet](https://github.com/heroku/hatchet) tests on `heroku-18` run:

```
$ circleci local execute --job hatchet-heroku-18 \
    --env HEROKU_API_USER=$(heroku whoami) \
    --env HEROKU_API_KEY=$(heroku auth:token)
```

Available jobs are defined in [.circleci/config.yml](.circleci/config.yml).

### Costs

This command uses the credentials from your local `heroku` configuration. This means your account will be billed for any
cost these tests incur. Proceed with caution.

## Troubleshooting

To see what the buildpack has produced, do `heroku run bash` and you
will be logged into an environment with your compiled app available.
From there you can explore the filesystem and run `lein` commands.
