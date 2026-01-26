# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Clojure' do
  it 'works with lein 2.x uberjar' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.deploy do
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing Clojure 1.12.4.1582 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into /app/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into /app/.heroku/clj/bin
          remote:        Installing man pages into /app/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Reading Leiningen project properties
          remote: -----> Installing Leiningen 2.9.1
          remote: -----> Building with Leiningen
          remote:        Running: lein uberjar
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
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
          remote:        Done: 111.3M
        OUTPUT

        app.commit!
        app.push!

        # Second build should use cached artifacts and doesn't recompile previously compiled application files
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing Clojure 1.12.4.1582 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into /app/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into /app/.heroku/clj/bin
          remote:        Installing man pages into /app/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Reading Leiningen project properties
          remote: -----> Installing Leiningen 2.9.1
          remote: -----> Building with Leiningen
          remote:        Running: lein uberjar
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          remote:        Compiling com.heroku.ci.core
          remote:        $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          remote:        Compiling com.heroku.ci.core
          remote:        Created $BUILD_DIR/target/heroku-minimal-clojure-0.1.0.jar
          remote:        Created $BUILD_DIR/target/app-standalone.jar
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web

          remote: -----> Compressing...
          remote:        Done: 111.3M
        OUTPUT
      end
    end
  end

  it 'works with lein 2.x without uberjar' do
    new_default_hatchet_runner('lein-2.x-no-uberjar').tap do |app|
      app.deploy do
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing Clojure 1.12.4.1582 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into /app/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into /app/.heroku/clj/bin
          remote:        Installing man pages into /app/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Reading Leiningen project properties
          remote: -----> Installing Leiningen 2.9.1
          remote: -----> Building with Leiningen
          remote:        Running: lein with-profile production compile :all
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
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
          remote:        Done: 108.8M
        OUTPUT

        app.commit!
        app.push!

        # Second build should use cached artifacts and doesn't recompile previously compiled application files
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing Clojure 1.12.4.1582 CLI tools
          remote:        Downloading and expanding tar
          remote:        Installing libs into /app/.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into /app/.heroku/clj/bin
          remote:        Installing man pages into /app/.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help.
          remote: -----> Reading Leiningen project properties
          remote: -----> Installing Leiningen 2.9.1
          remote: -----> Building with Leiningen
          remote:        Running: lein with-profile production compile :all
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          remote:        Compiling com.heroku.ci.core
          remote:        $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web

          remote: -----> Compressing...
          remote:        Done: 108.8M
        OUTPUT
      end
    end
  end

  it 'uses custom bin/build script when present' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.before_deploy do
        FileUtils.mkdir_p('bin')
        File.write('bin/build', <<~SCRIPT)
          #!/usr/bin/env bash
          echo "Running custom build script"
          lein deps
        SCRIPT
        File.chmod(0o755, 'bin/build')
      end

      app.deploy do
        expect(clean_output(app.output)).to include('Found bin/build; running it instead of default lein invocation.')
        expect(clean_output(app.output)).to include('Running: bin/build')
        expect(clean_output(app.output)).to include('Running custom build script')
      end
    end
  end

  it 'detects and uses vendored leiningen from bin/lein' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.before_deploy do
        require 'open-uri'
        FileUtils.mkdir_p('bin')
        lein_content = URI.open('https://codeberg.org/leiningen/leiningen/raw/tag/2.9.1/bin/lein').read
        File.write('bin/lein', lein_content)
        File.chmod(0o755, 'bin/lein')
      end

      app.deploy do
        expect(clean_output(app.output)).to include('Using vendored Leiningen at bin/lein')
      end
    end
  end

  it 'fails the build when lein compilation fails' do
    new_default_hatchet_runner('lein-2.x-with-uberjar', allow_failure: true).tap do |app|
      app.before_deploy do
        File.write('src/com/heroku/ci/core.clj', '(this will not compile')
      end

      app.deploy do
        expect(app).not_to be_deployed
        expect(app.output).to include('Failed to build.')
      end
    end
  end
end
