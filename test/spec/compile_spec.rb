# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Clojure' do
  it 'works with lein 2.x uberjar' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.deploy do
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure (Leiningen 2) app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing rlwrap... 
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote: rm: cannot remove '/var/cache/apt/archives/partial/*.deb': Permission denied
          remote:        Fetched $SIZE in $TIME ($SPEED)
          remote:        Reading package lists...
          remote:        Reading package lists...
          remote:        Building dependency tree...
          remote:        The following NEW packages will be installed:
          remote:          rlwrap
          remote:        0 upgraded, 1 newly installed, 0 to remove and 18 not upgraded.
          remote:        Need to get 107 kB of archives.
          remote:        After this operation, 328 kB of additional disk space will be used.
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Fetched $SIZE in $TIME ($SPEED)
          remote:        Download complete and in download only mode
          remote: -----> Installing Clojure 1.10.0.411 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into $BUILD_DIR/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into $BUILD_DIR/.heroku/clj/bin
          remote:        Installing man pages into $BUILD_DIR/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Installing Leiningen
          remote:        Downloading: leiningen-2.9.1-standalone.jar
          remote:        Writing: lein script
          remote: cp: warning: behavior of -n is non-portable and may change in future; use --update=none instead
          remote: -----> Building with Leiningen
          remote:        Running: lein uberjar
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          remote:        $CURL_PROGRESS_OUTPUT
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Compiling com.heroku.ci.core
          remote:        $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          remote:        Compiling com.heroku.ci.core
          remote:        Created $BUILD_DIR/target/heroku-minimal-clojure-0.1.0.jar
          remote:        Created $BUILD_DIR/target/app-standalone.jar
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web
          
          remote: -----> Compressing...
          remote:        Done: 115.5M
        OUTPUT

        app.commit!
        app.push!

        # Second build should use cached artifacts and doesn't recompile previously compiled application files
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure (Leiningen 2) app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing rlwrap... 
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote: rm: cannot remove '/var/cache/apt/archives/partial/*.deb': Permission denied
          remote:        Reading package lists...
          remote:        Reading package lists...
          remote:        Building dependency tree...
          remote:        The following NEW packages will be installed:
          remote:          rlwrap
          remote:        0 upgraded, 1 newly installed, 0 to remove and 18 not upgraded.
          remote:        Need to get 0 B/107 kB of archives.
          remote:        After this operation, 328 kB of additional disk space will be used.
          remote:        Download complete and in download only mode
          remote: -----> Installing Clojure 1.10.0.411 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into $BUILD_DIR/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into $BUILD_DIR/.heroku/clj/bin
          remote:        Installing man pages into $BUILD_DIR/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Using cached Leiningen 2.9.1
          remote:        Writing: lein script
          remote: cp: warning: behavior of -n is non-portable and may change in future; use --update=none instead
          remote: -----> Building with Leiningen
          remote:        Running: lein uberjar
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          remote:        $CURL_PROGRESS_OUTPUT
          remote:        Compiling com.heroku.ci.core
          remote:        $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          remote:        Compiling com.heroku.ci.core
          remote:        Created $BUILD_DIR/target/heroku-minimal-clojure-0.1.0.jar
          remote:        Created $BUILD_DIR/target/app-standalone.jar
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web
          
          remote: -----> Compressing...
          remote:        Done: 115.5M
        OUTPUT
      end
    end
  end

  it 'works with lein 2.x without uberjar' do
    new_default_hatchet_runner('lein-2.x-no-uberjar').tap do |app|
      app.deploy do
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure (Leiningen 2) app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing rlwrap... 
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote: rm: cannot remove '/var/cache/apt/archives/partial/*.deb': Permission denied
          remote:        Fetched $SIZE in $TIME ($SPEED)
          remote:        Reading package lists...
          remote:        Reading package lists...
          remote:        Building dependency tree...
          remote:        The following NEW packages will be installed:
          remote:          rlwrap
          remote:        0 upgraded, 1 newly installed, 0 to remove and 18 not upgraded.
          remote:        Need to get 107 kB of archives.
          remote:        After this operation, 328 kB of additional disk space will be used.
          remote:        Get:$NUM $PACKAGE [$SIZE]
          remote:        Fetched $SIZE in $TIME ($SPEED)
          remote:        Download complete and in download only mode
          remote: -----> Installing Clojure 1.10.0.411 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into $BUILD_DIR/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into $BUILD_DIR/.heroku/clj/bin
          remote:        Installing man pages into $BUILD_DIR/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Installing Leiningen
          remote:        Downloading: leiningen-2.9.1-standalone.jar
          remote:        Writing: lein script
          remote: cp: warning: behavior of -n is non-portable and may change in future; use --update=none instead
          remote: -----> Building with Leiningen
          remote:        Running: lein with-profile production compile :all
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          remote:        $CURL_PROGRESS_OUTPUT
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Compiling com.heroku.ci.core
          remote:        $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web

          remote: -----> Compressing...
          remote:        Done: 125.6M
        OUTPUT

        app.commit!
        app.push!

        # Second build should use cached artifacts and doesn't recompile previously compiled application files
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure (Leiningen 2) app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing rlwrap... 
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote:        Hit:$NUM $REPO InRelease
          remote: rm: cannot remove '/var/cache/apt/archives/partial/*.deb': Permission denied
          remote:        Reading package lists...
          remote:        Reading package lists...
          remote:        Building dependency tree...
          remote:        The following NEW packages will be installed:
          remote:          rlwrap
          remote:        0 upgraded, 1 newly installed, 0 to remove and 18 not upgraded.
          remote:        Need to get 0 B/107 kB of archives.
          remote:        After this operation, 328 kB of additional disk space will be used.
          remote:        Download complete and in download only mode
          remote: -----> Installing Clojure 1.10.0.411 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into $BUILD_DIR/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into $BUILD_DIR/.heroku/clj/bin
          remote:        Installing man pages into $BUILD_DIR/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Using cached Leiningen 2.9.1
          remote:        Writing: lein script
          remote: cp: warning: behavior of -n is non-portable and may change in future; use --update=none instead
          remote: -----> Building with Leiningen
          remote:        Running: lein with-profile production compile :all
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          remote:        $CURL_PROGRESS_OUTPUT
          remote:        Compiling com.heroku.ci.core
          remote:        $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web

          remote: -----> Compressing...
          remote:        Done: 125.6M
        OUTPUT
      end
    end
  end
end
