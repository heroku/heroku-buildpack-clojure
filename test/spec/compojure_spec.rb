require_relative "spec_helper"

describe "Compojure" do
  context "on jdk-#{DEFAULT_OPENJDK_VERSION}" do
    it "deploys clojure-minimal successfully" do
      new_default_hatchet_runner("clojure-minimal").tap do |app|
        app.before_deploy do
          set_java_version(DEFAULT_OPENJDK_VERSION)
        end

        app.deploy do
          expect(app.output).to include("Installing JDK #{DEFAULT_OPENJDK_VERSION}")
          expect(app.output).to match(/Downloading: leiningen-2.[0-9].[0-9]-standalone.jar/)
          expect(app.output).to include("Running: lein uberjar")
          expect(http_get(app)).to include('["Hello" :from Heroku]')
        end
      end
    end
  end
end
