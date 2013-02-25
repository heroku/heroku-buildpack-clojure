# Heroku buildpack: Clojure

This is a Heroku buildpack for Clojure apps. It uses
[Leiningen](http://leiningen.org).

Note that you don't have to do anything special to use this buildpack
with Clojure apps on Heroku; it will be used by default for all
projects containing a project.clj file, though it may be an older
revision than current master. 

## Usage

Example usage for an app already stored in git:

    $ tree
    |-- Procfile
    |-- project.clj
    |-- README
    `-- src
        `-- sample
            `-- core.clj

    $ heroku create

    $ git push heroku master
    ...
    -----> Heroku receiving push
    -----> Fetching custom buildpack
    -----> Clojure app detected
    -----> Installing Leiningen
           Downloading: leiningen-2.0.0-preview10-standalone.jar
           Writing: lein script
    -----> Building with Leiningen
           Running: with-profile production compile :all
           Downloading: org/clojure/clojure/1.2.1/clojure-1.2.1.pom from central
           Downloading: org/clojure/clojure/1.2.1/clojure-1.2.1.jar from central
           Copying 1 file to /tmp/build_2e5yol0778bcw/lib
    -----> Discovering process types
           Procfile declares types -> core
    -----> Compiled slug size is 10.0MB
    -----> Launching... done, v4
           http://gentle-water-8841.herokuapp.com deployed to Heroku

The buildpack will detect your app as Clojure if it has a
`project.clj` file in the root. If you use the
[clojure-maven-plugin](https://github.com/talios/clojure-maven-plugin),
[the standard Java buildpack](http://github.com/heroku/heroku-buildpack-java)
should work instead. Leiningen 1.7.1 will be used by default, but if
you have `:min-lein-version "2.0.0"` in project.clj then Leiningen 2.x
will be used instead.

## Configuration

By default your project is built by running `lein deps` under
Leiningen 1.x and `lein compile :all` under Leiningen 2.x. To
customize this, check in a `bin/build` script into your project and it
will be run instead of invoking `lein` directly.

If you are using Leiningen 2.x, it's highly recommended that you use
the `:production` profile in your `Procfile` and/or `bin/build` to avoid
having tests and development dependencies on your classpath in
production.

If you don't need to add anything to the `:production` profile then
you can leave it out and the one from `opt/profiles.clj` in the
buildpack will be used. If you do need to add something, it's
recommended you include `:mirrors` for faster dependency resolution
from S3 for Central:

```clj
:production {:app-specific "config"
             :mirrors {"central" "http://s3pository.herokuapp.com/maven-central"}}
```

Since Clojars currently mixes snapshots and releases it's currently
not appropriate to mirror to S3 unless you know for sure you're not
using any snapshots even transitively.

You should reduce memory consumption by using the `trampoline` task in
your Procfile. This will cause Leiningen to calculate the classpath
and code to run for your project, then exit and execute your project's
JVM:

    web: lein with-profile offline,production trampoline run -m myapp.web

## JDK Version

By default you will get OpenJDK 1.6. To use a different version, you
can commit a `system.properties` file to your app.

```
$ echo "java.runtime.version=1.7" > system.properties
$ git add system.properties
$ git commit -m "JDK 7"
```

## Hacking

To change this buildpack, fork it on GitHub. Push up changes to your
fork, then create a test app with `--buildpack YOUR_GITHUB_URL` and
push to it. If you already have an existing app you may use
`heroku config:add BUILDPACK_URL=YOUR_GITHUB_URL` instead.

For example, you could adapt it to generate an uberjar at build time.

Open `bin/compile` in your editor, and replace the block labeled
"fetch deps with lein" with something like this:

    echo "-----> Generating uberjar with Leiningen:"
    echo "       Running: lein uberjar"
    cd $BUILD_DIR
    PATH=.lein/bin:/usr/local/bin:/usr/bin:/bin JAVA_OPTS="-Xmx500m -Duser.home=$BUILD_DIR" lein uberjar 2>&1 | sed -u 's/^/       /'
    if [ "${PIPESTATUS[*]}" != "0 0" ]; then
      echo " !     Failed to create uberjar with Leiningen"
      exit 1
    fi

Commit and push the changes to your buildpack to your GitHub fork,
then push your sample app to Heroku to test. The output should include:

    -----> Generating uberjar with Leiningen:

If it's something other users would find useful, pull requests are welcome.

## Troubleshooting

To see what the buildpack has produced, do `heroku run bash` and you
will be logged into an environment with your compiled app available.
From there you can explore the filesystem and run `lein` commands.
