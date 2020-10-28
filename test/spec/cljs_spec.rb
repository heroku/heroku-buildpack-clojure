require_relative "spec_helper"

describe "ClojureScript" do
  context "on jdk-#{DEFAULT_OPENJDK_VERSION}" do
    it "deploys clojurescript-example successfully" do
      new_default_hatchet_runner("clojurescript-example").tap do |app|
        app.before_deploy do
          set_java_version(DEFAULT_OPENJDK_VERSION)
        end

        app.deploy do
          expect(app.output).to include("Installing JDK #{DEFAULT_OPENJDK_VERSION}")
          expect(app.output).to match(/Downloading: leiningen-2.[5-9].[0-9]-standalone.jar/)
          expect(app.output).to include("Running: lein uberjar")

          expect(http_get(app)).to include("Welcome from ClojureScript")
        end
      end
    end

    it "deploys cljs-lein-npm-example successfully" do
      new_default_hatchet_runner("cljs-lein-npm-example").tap do |app|
        app.before_deploy do
          set_java_version(DEFAULT_OPENJDK_VERSION)
        end

        app.deploy do
          expect(app.output).to include("Installing JDK #{DEFAULT_OPENJDK_VERSION}")
          expect(app.output).to match(/Downloading: leiningen-2.[5-9].[0-9]-standalone.jar/)
          expect(app.output).to include("Running: lein with-profile production do deps, compile :all")

          expect(http_get(app)).to include("Jokes")
        end
      end
    end
  end
end
