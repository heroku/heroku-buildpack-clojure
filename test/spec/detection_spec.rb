# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack detection' do
  it 'shows error message when project.clj is missing' do
    Hatchet::Runner.new('non-clojure-app', allow_failure: true).tap do |app|
      app.deploy do
        expect(app).not_to be_deployed
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> App not compatible with buildpack: $BUILDPACK_URL
          remote:        Could not find a 'project.clj' file! Please ensure it exists and is checked into Git.

          remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure

          remote:  !     Push failed
        OUTPUT
      end
    end
  end
end
