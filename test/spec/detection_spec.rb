# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack detection' do
  it 'shows error message when project.clj is missing' do
    Hatchet::Runner.new('non-clojure-app', allow_failure: true).tap do |app|
      app.deploy do
        expect(app).not_to be_deployed
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> App not compatible with buildpack: $BUILDPACK_URL
          remote:
          remote:  !     Error: Your app is configured to use the Clojure buildpack,
          remote:  !     but we couldn't find any supported Leiningen project files.
          remote:  !
          remote:  !     The Clojure buildpack requires a 'project.clj' file
          remote:  !     in the root directory of your source code.
          remote:  !
          remote:  !     Currently the root directory of your app contains:
          remote:  !
          remote:  !     README.md
          remote:  !
          remote:  !     If your app already has a project.clj file, check that it:
          remote:  !
          remote:  !     1. Is in the correct directory (see requirements above).
          remote:  !     2. Has the correct spelling (the filename is case-sensitive).
          remote:  !     3. Isn't listed in '.gitignore' or '.slugignore'.
          remote:  !     4. Has been added to the Git repository using 'git add --all'
          remote:  !        and then committed using 'git commit'.
          remote:  !
          remote:  !     For help with using Leiningen on Heroku, see:
          remote:  !     https://devcenter.heroku.com/articles/clojure-support


          remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure

          remote:  !     Push failed
        OUTPUT
      end
    end
  end
end
