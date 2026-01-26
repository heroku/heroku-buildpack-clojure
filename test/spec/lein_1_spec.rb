# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Leiningen 1.x' do
  it 'fails with error message when lein 1.x is detected' do
    new_default_hatchet_runner('lein-1.x', allow_failure: true).tap do |app|
      app.deploy do
        expect(app).not_to be_deployed
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

          remote:  !     Error: Leiningen 1.x is no longer supported by this buildpack.
          remote:  !
          remote:  !     Please upgrade to Leiningen 2.x by setting :min-lein-version in your project.clj:
          remote:  !
          remote:  !       (defproject your-project "version"
          remote:  !         :min-lein-version "2.0.0"
          remote:  !         ...)
          remote:  !
          remote:  !     If you need to use a custom Leiningen version, you can vendor the lein script
          remote:  !     in your repository at bin/build.
          remote:  !
          remote:  !     For more information, see:
          remote:  !     https://web.archive.org/web/20160225024908/https://github.com/technomancy/leiningen/wiki/Upgrading

          remote:  !     Push rejected, failed to compile Clojure app.

          remote:  !     Push failed
        OUTPUT
      end
    end
  end
end
