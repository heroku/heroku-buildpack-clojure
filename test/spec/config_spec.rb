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

  it 'fails with a helpful error when CLOJURE_CLI_VERSION does not exist' do
    new_default_hatchet_runner('lein-2.x-with-uberjar', allow_failure: true).tap do |app|
      app.before_deploy do
        app.set_config('CLOJURE_CLI_VERSION' => '0.0.0.0')
      end

      app.deploy do
        expect(app).not_to be_deployed
        expect(clean_output(app.output)).to eq(<<~OUTPUT)
          remote: -----> Clojure app detected
          remote: -----> Installing Azul Zulu OpenJDK $VERSION
          remote: -----> Installing Clojure 0.0.0.0 CLI tools
          remote: curl: (22) The requested URL returned error: 403

          remote:  !     Error: Unable to download the Clojure CLI tools installer.
          remote:  !
          remote:  !     Failed to download the installer script for Clojure CLI tools 0.0.0.0 from:
          remote:  !     https://download.clojure.org/install/linux-install-0.0.0.0.sh
          remote:  !
          remote:  !     This can happen if the requested version doesn't exist. If you
          remote:  !     set the CLOJURE_CLI_VERSION config var, check that it refers to
          remote:  !     a valid Clojure CLI tools release:
          remote:  !     https://clojure.org/releases/tools
          remote:  !
          remote:  !     In other cases, this happens due to a temporary issue with the
          remote:  !     network connection or the Clojure download server. Try building
          remote:  !     again to see if the error resolves itself.

          remote:  !     Push rejected, failed to compile Clojure app.

          remote:  !     Push failed
        OUTPUT
      end
    end
  end

  it 'respects BUILD_COMMAND environment variable override' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.before_deploy do
        app.set_config('BUILD_COMMAND' => 'lein deps')
      end

      app.deploy do
        expect(clean_output(app.output)).to include('Running: lein deps')
        expect(clean_output(app.output)).not_to include('Running: lein uberjar')
      end
    end
  end
end
