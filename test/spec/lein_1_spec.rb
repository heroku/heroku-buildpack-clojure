# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Leiningen 1.x' do
  it 'works with lein 1.x' do
    new_default_hatchet_runner('lein-1.x').tap do |app|
      app.deploy do
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure app detected
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
          
          remote:  !     WARNING: No :min-lein-version found in project.clj; using 1.7.1.
          remote:          You probably don't want this!
          
          remote: -----> Installing Leiningen
          remote:        Downloading: leiningen-1.7.1-standalone.jar
          remote:        To use Leiningen 2.x, add this to project.clj: :min-lein-version "2.0.0"
          remote:        Writing: lein script
          remote: cp: warning: behavior of -n is non-portable and may change in future; use --update=none instead
          remote: -----> Building with Leiningen
          remote:        Running: lein deps
          remote:        Downloading: org/clojure/clojure/1.5.1/clojure-1.5.1.pom from repository central-https at https://repo1.maven.org/maven2
          remote:        Downloading: org/sonatype/oss/oss-parent/5/oss-parent-5.pom from repository central-https at https://repo1.maven.org/maven2
          remote:        Downloading: org/clojure/clojure/1.5.1/clojure-1.5.1.jar from repository central-https at https://repo1.maven.org/maven2
          remote:        Transferring 3501K from central-https
          remote:        Copying 1 file to $BUILD_DIR/lib
          remote: -----> Discovering process types
          remote:        Procfile declares types     -> (none)
          remote:        Default types for buildpack -> web
          
          remote: -----> Compressing...
          remote:        Done: 82.2M
        OUTPUT
      end
    end
  end
end
