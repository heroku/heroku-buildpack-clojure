# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack' do
  it 'installs Node.js when lein-npm is detected' do
    new_default_hatchet_runner('lein-2.x-with-lein-npm').tap do |app|
      app.deploy do
        # Verify Node.js installation
        expect(clean_output(app.output)).to include('-----> Installing Node.js 18.16.0...')
        expect(clean_output(app.output)).to include('Downloading Node.js 18.16.0...')

        # Verify correct build task for lein-npm
        expect(clean_output(app.output)).to include('Running: lein with-profile production do deps, compile :all')

        # Verify successful deployment
        expect(app).to be_deployed
      end
    end
  end

  it 'installs Node.js when lein-npm is detected (full output match)' do
    new_default_hatchet_runner('lein-2.x-with-lein-npm').tap do |app|
      app.deploy do
        expect(clean_output(app.output)).to match(<<~OUTPUT)
          remote: -----> Clojure (Leiningen 2) app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing Node.js 18.16.0...
          remote:        Downloading Node.js 18.16.0...
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
          remote:        0 upgraded, 1 newly installed, 0 to remove and 19 not upgraded.
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
          remote:        Running: lein with-profile production do deps, compile :all
          remote:        Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          remote:          $CURL_PROGRESS_OUTPUT
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Warning: implicit hook found: lein-npm.plugin/hooks 
          remote:        Hooks are deprecated and will be removed in a future version.
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        Retrieving $DEPENDENCY from $REPO
          remote:        
          remote:        up to date, audited $NUM packages in $TIME
          remote:        
          remote:        found 0 vulnerabilities
          remote:        Compiling com.heroku.ci.core
          remote:        $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web

          remote: -----> Compressing...
          remote:        Done: 171.4M
        OUTPUT
      end
    end
  end

  it 'respects NODEJS_VERSION environment variable' do
    new_default_hatchet_runner('lein-2.x-with-lein-npm').tap do |app|
      app.before_deploy do
        app.set_config('NODEJS_VERSION' => '20.10.0')
      end

      app.deploy do
        # Verify custom Node.js version is installed
        expect(clean_output(app.output)).to include('-----> Installing Node.js 20.10.0')
        expect(clean_output(app.output)).to include('Downloading Node.js 20.10.0')

        # Verify successful deployment
        expect(app).to be_deployed
      end
    end
  end

  it 'skips Node.js installation when SKIP_NODEJS_INSTALL is set' do
    new_default_hatchet_runner('lein-2.x-with-lein-npm').tap do |app|
      app.before_deploy do
        app.set_config('SKIP_NODEJS_INSTALL' => 'true')
      end

      app.deploy do
        # Verify Node.js installation is skipped
        expect(clean_output(app.output)).not_to include('-----> Installing Node.js')
        expect(clean_output(app.output)).not_to include('Downloading Node.js')

        # Verify successful deployment
        expect(app).to be_deployed
      end
    end
  end
end
