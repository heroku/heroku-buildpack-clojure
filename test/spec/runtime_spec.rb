# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Clojure buildpack runtime' do
  it 'makes clj and lein available at runtime' do
    new_default_hatchet_runner('lein-2.x-no-uberjar').tap do |app|
      app.deploy do
        expect(app).to be_deployed

        # Verify clj is available and works
        clj_output = app.run('clj -e \'(println "Clojure works")\'')
        expect(clj_output).to eq(<<~OUTPUT)
          Warning: Using minimal rlwrap replacement. Command history and line editing are not available.
          To enable full readline support, add the APT buildpack and create an Aptfile:

          1. heroku buildpacks:add --index 1 heroku-community/apt
          2. echo "rlwrap" > Aptfile
          3. git add Aptfile && git commit -m "Add rlwrap support"
          4. git push heroku main

          Downloading: org/clojure/clojure/1.10.0/clojure-1.10.0.pom from https://repo1.maven.org/maven2/
          Downloading: org/clojure/spec.alpha/0.2.176/spec.alpha-0.2.176.pom from https://repo1.maven.org/maven2/
          Downloading: org/clojure/core.specs.alpha/0.2.44/core.specs.alpha-0.2.44.pom from https://repo1.maven.org/maven2/
          Downloading: org/clojure/clojure/1.10.0/clojure-1.10.0.jar from https://repo1.maven.org/maven2/
          Downloading: org/clojure/spec.alpha/0.2.176/spec.alpha-0.2.176.jar from https://repo1.maven.org/maven2/
          Downloading: org/clojure/core.specs.alpha/0.2.44/core.specs.alpha-0.2.44.jar from https://repo1.maven.org/maven2/
          Clojure works
        OUTPUT

        # Verify lein is available
        lein_output = app.run('lein version')
        expect(lein_output).to match(/Downloading Leiningen to \/app\/\.lein\/self-installs\/leiningen-\d+\.\d+\.\d+-standalone\.jar now\.\.\./)
        expect(lein_output).to match(/Leiningen \d+\.\d+\.\d+ on Java \d+\.\d+\.\d+ OpenJDK 64-Bit Server VM/)
      end
    end
  end
end
