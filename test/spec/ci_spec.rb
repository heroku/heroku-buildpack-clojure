# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack' do
  it 'runs tests on Heroku CI' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.run_ci do |test_run|
        # First CI run should build from scratch
        expect(clean_output(test_run.output)).to eq(<<~OUTPUT)
          -----> Clojure app detected
          -----> Installing Azul Zulu OpenJDK $VERSION
          -----> Installing Clojure 1.12.4.1582 CLI tools
                 Downloading and expanding tar
                 Installing libs into /app/.heroku/clj/lib/clojure
                 Installing clojure and clj into /app/.heroku/clj/bin
                 Installing man pages into /app/.heroku/clj/share/man/man1
                 Removing download
                 Use clj -h for help.
          -----> Reading Leiningen project properties
          -----> Installing Leiningen 2.9.1
          -----> Building with Leiningen
                 Running: lein deps
                 Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
                 Retrieving $DEPENDENCY from $REPO
          -----> No test-setup command provided. Skipping.
          -----> Running Clojure buildpack tests...
          Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8 -XX:MaxRAM=2684354560 -XX:MaxRAMPercentage=80.0
          OpenJDK 64-Bit Server VM warning: Options -Xverify:none and -noverify were deprecated in JDK 13 and will likely be removed in a future release.
          Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8 -XX:MaxRAM=2684354560 -XX:MaxRAMPercentage=80.0
          Compiling com.heroku.ci.core
          $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8 -XX:MaxRAM=2684354560 -XX:MaxRAMPercentage=80.0
          $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog

          lein test com.heroku.ci.core-test

          Ran 2 tests containing 2 assertions.
          0 failures, 0 errors.
          -----> Clojure buildpack tests completed successfully
        OUTPUT

        test_run.run_again

        # Second CI run should use cached artifacts
        expect(clean_output(test_run.output)).to eq(<<~OUTPUT)
          -----> Clojure app detected
          -----> Installing Azul Zulu OpenJDK $VERSION
          -----> Installing Clojure 1.12.4.1582 CLI tools
                 Downloading and expanding tar
                 Installing libs into /app/.heroku/clj/lib/clojure
                 Installing clojure and clj into /app/.heroku/clj/bin
                 Installing man pages into /app/.heroku/clj/share/man/man1
                 Removing download
                 Use clj -h for help.
          -----> Reading Leiningen project properties
          -----> Installing Leiningen 2.9.1
          -----> Building with Leiningen
                 Running: lein deps
                 Downloading Leiningen to /app/.lein/self-installs/leiningen-2.9.1-standalone.jar now...
          -----> No test-setup command provided. Skipping.
          -----> Running Clojure buildpack tests...
          Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8 -XX:MaxRAM=2684354560 -XX:MaxRAMPercentage=80.0
          OpenJDK 64-Bit Server VM warning: Options -Xverify:none and -noverify were deprecated in JDK 13 and will likely be removed in a future release.
          Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8 -XX:MaxRAM=2684354560 -XX:MaxRAMPercentage=80.0
          Compiling com.heroku.ci.core
          $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=UTF-8 -XX:MaxRAM=2684354560 -XX:MaxRAMPercentage=80.0
          $TIMESTAMP:INFO::main: Logging initialized @$TIMEms to org.eclipse.jetty.util.log.StdErrLog
          
          lein test com.heroku.ci.core-test
          
          Ran 2 tests containing 2 assertions.
          0 failures, 0 errors.
          -----> Clojure buildpack tests completed successfully
        OUTPUT
      end
    end
  end
end
