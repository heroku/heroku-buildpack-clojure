# Heroku buildpack: Clojure

This is a Heroku buildpack for Clojure apps. It uses
[Leiningen](https://github.com/technomancy/leiningen).

Note that you don't have to do anything special to use this buildpack
with Clojure apps on Heroku; it will be used by default for all
projects containing a project.clj file, though it may be an older
revision than current master. This repository is made available so
users can fork for their own needs and contribute patches back.

## Usage

Example usage for an app already stored in git:

    $ tree
    |-- Procfile
    |-- project.clj
    |-- README
    `-- src
        `-- sample
            `-- core.clj

    $ heroku create --stack cedar --buildpack http://github.com/heroku/heroku-buildpack-clojure.git

    $ git push heroku master
    ...
    -----> Heroku receiving push
    -----> Fetching custom buildpack
    -----> Clojure app detected
    -----> Installing Leiningen
           Downloading: leiningen-1.7.1-standalone.jar
           Downloading: rlwrap-0.3.7
           Writing: lein script
    -----> Installing dependencies with Leiningen
           Running: LEIN_NO_DEV=y lein deps
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
should work instead.

## Configuration

Currently most of the build-level configurations require turning on the
[user_env_compile](http://devcenter.heroku.com/articles/labs-user-env-compile)
functionality so the build step will have access to environment variables.

By default your project is built by running `lein deps`, which copies
all the dependencies into the `lib` directory. You may wish to perform
a full AOT compile during build; this is done by setting
`LEIN_BUILD_TASK=compile :all`. This has the benefit of both speeding
up dyno launch times and catching certain classes of error during push.

By default your project will run in "no dev" mode, which means
`:dev-dependencies` will not be available and the `test` and
`test-resources` directories will not be on the classpath. You can set
`LEIN_DEV=y` to disable this if you need access to a plugin at runtime.

Finally, you can reduce memory consumption by using the `trampoline`
task in your Procfile. This will cause Leiningen to calculate the
classpath and code to run for your project, then exit and execute your
project's JVM:

    web: lein trampoline run -m myapp.web

## Hacking

To change this buildpack, fork it on GitHub. Push up changes to your
fork, then create a test app with `--buildpack YOUR_GITHUB_URL` and
push to it. If you already have an existing app you may use
`heroku config:add BUILDPACK_URL=YOUR_GITHUB_URL` instead.

For example, you could adapt it to generate an uberjar at build time.

Open `bin/compile` in your editor, and replace the block labeled
"fetch deps with lein" with something like this:

    echo "-----> Generating uberjar with Leiningen:"
    echo "       Running: LEIN_NO_DEV=y lein uberjar"
    cd $BUILD_DIR
    PATH=.lein/bin:/usr/local/bin:/usr/bin:/bin JAVA_OPTS="-Xmx500m -Duser.home=$BUILD_DIR" LEIN_NO_DEV=y lein uberjar 2>&1 | sed -u 's/^/       /'
    if [ "${PIPESTATUS[*]}" != "0 0" ]; then
      echo " !     Failed to create uberjar with Leiningen"
      exit 1
    fi

The `LEIN_NO_DEV` environment variable will cause Leiningen to keep
the test directories and dev dependencies off the classpath, so be
sure to set it for every `lein` invocation.

Commit and push the changes to your buildpack to your GitHub fork,
then push your sample app to Heroku to test. You should see:

    -----> Generating uberjar with Leiningen:

## Troubleshooting

To see what the buildpack has produced, do `heroku run bash` and you
will be logged into an environment with your compiled app available.
From there you can explore the filesystem and run `lein` commands.

Note that projects with the `:local-repo-classpath` option set in
`project.clj` will cause dependencies to be re-fetched when each
process is started, which is highly undesirable. It's recommended you
disable this option.
