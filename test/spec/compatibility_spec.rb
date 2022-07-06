require_relative "spec_helper"

describe "Heroku's Clojure Support" do

  it "successfully compiles a project when the heroku/google-chrome buildpack is also used" do
    new_default_hatchet_runner("test/spec/fixtures/repos/lein-2-jdk-8", buildpacks: ["heroku/google-chrome", :default]).tap do |app|
      app.deploy do
        expect(app.output).to include("Google Chrome app detected")
        expect(app.output).to include("Installing OpenJDK 1.8... done")
        expect(app.output).to include("Downloading: leiningen-2.9.1-standalone.jar")
      end
    end
  end
end
