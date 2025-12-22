# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack' do
  it 'can build and run Heroku\'s Clojure getting started app' do
    app = Hatchet::Runner.new('clojure-getting-started')
    app.deploy do
      expect(http_get(app)).to include('Clojure Getting Started on Heroku')
    end
  end
end
