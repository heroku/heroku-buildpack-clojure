# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack' do
  it 'fails when lein-npm is detected without npm' do
    new_default_hatchet_runner('lein-2.x-with-lein-npm', allow_failure: true).tap do |app|
      app.deploy do
        expect(clean_output(app.output)).to match(<<~OUTPUT)
          remote: -----> Clojure app detected
          remote: -----> Installing Azul Zulu OpenJDK \\$VERSION
          remote: -----> Installing Clojure 1\\.12\\.4\\.1597 CLI tools
          remote:        Downloading and expanding tar
          remote:        clojure-tools-1\\.12\\.4\\.1597\\.tar\\.gz: OK
          remote:        Installing libs into /app/\\.heroku/clj/lib/clojure
          remote:        Installing clojure and clj into /app/\\.heroku/clj/bin
          remote:        Installing man pages into /app/\\.heroku/clj/share/man/man1
          remote:        Removing download
          remote:        Use clj -h for help\\.
          remote: -----> Reading Leiningen project properties

          remote:  !     Error: Your project.clj references lein-npm but npm is not available.
          remote:  !
          remote:  !     The Clojure buildpack no longer automatically installs Node.js.
          remote:  !
          remote:  !     If your project uses the lein-npm plugin, you must explicitly add the Node.js buildpack to provide Node.js and npm.
          remote:  !
          remote:  !     To add the Node.js buildpack to your app, run:
          remote:  !       heroku buildpacks:add --index 1 heroku/nodejs
          remote:  !
          remote:  !     For more information, see:
          remote:  !     https://devcenter.heroku.com/articles/nodejs-support
          remote:  !     https://devcenter.heroku.com/articles/managing-buildpacks#use-multiple-buildpacks

          remote:  !     Push rejected, failed to compile Clojure app.

          remote:  !     Push failed
        OUTPUT

        expect(app).not_to be_deployed
      end
    end
  end
end
