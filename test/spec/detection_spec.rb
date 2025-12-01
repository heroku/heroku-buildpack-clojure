# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack detection' do
  it 'shows error message when project.clj is missing' do
    Hatchet::Runner.new('non-clojure-app', allow_failure: true).tap do |app|
      app.deploy do
        expect(app).not_to be_deployed
        expect(app.output).to include("Could not find a 'project.clj' file! Please ensure it exists and is checked into Git.")
      end
    end
  end
end
