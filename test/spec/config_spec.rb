# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack configuration' do
  it 'respects LEIN_BUILD_TASK environment variable override' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.before_deploy do
        app.set_config('LEIN_BUILD_TASK' => 'deps')
      end

      app.deploy do
        expect(clean_output(app.output)).to include('Running: lein deps')
        expect(clean_output(app.output)).not_to include('Running: lein uberjar')
      end
    end
  end

  it 'respects CLOJURE_CLI_VERSION environment variable' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.before_deploy do
        app.set_config('CLOJURE_CLI_VERSION' => '1.11.1.1347')
      end

      app.deploy do
        expect(clean_output(app.output)).to include('Installing Clojure 1.11.1.1347 CLI tools')
      end
    end
  end

  it 'respects BUILD_COMMAND environment variable override' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.before_deploy do
        app.set_config('BUILD_COMMAND' => 'echo "Custom build command executed" && lein deps')
      end

      app.deploy do
        expect(clean_output(app.output)).to include('Running: echo "Custom build command executed" && lein deps')
        expect(clean_output(app.output)).to include('Custom build command executed')
        expect(clean_output(app.output)).not_to include('Running: lein uberjar')
      end
    end
  end
end
