# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack' do
  it 'configures the Google Maven Central mirror for Leiningen by default' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.deploy do
        expect(app.run('cat .lein/profiles.clj')).to include(
          '{:user {:mirrors ^:displace {"central" {:name "central" ' \
          ':url "https://maven-central.storage-download.googleapis.com/maven2/"}}}}'
        )
      end
    end
  end

  it 'does not configure the Google Maven Central mirror when MAVEN_CENTRAL_MIRROR is false' do
    new_default_hatchet_runner('lein-2.x-with-uberjar', config: { MAVEN_CENTRAL_MIRROR: 'false' }).tap do |app|
      app.deploy do
        expect(app.run('cat .lein/profiles.clj').strip).to eq('{}')
      end
    end
  end

  it 'prefers mirrors from project.clj over the Google Maven Central mirror' do
    new_default_hatchet_runner('lein-2.x-with-uberjar').tap do |app|
      app.before_deploy do
        project_clj = File.read('project.clj')
        File.write('project.clj', project_clj.sub(
                                    ':min-lein-version "2.0.0"',
                                    ':min-lein-version "2.0.0" ' \
                                    ':mirrors {"central" {:name "user-mirror" :url "https://repo1.maven.org/maven2/"}}'
                                  ))
      end

      app.deploy do
        expect(clean_output(app.output)).to include('from user-mirror')
        expect(clean_output(app.output)).not_to match(/Retrieving \S+ from central/)
      end
    end
  end
end
