require_relative 'spec_helper'

describe "Compojure" do
  before(:each) do
    set_java_version(app.directory, jdk_version)
  end

  %w{1.8}.each do |version|
    context "on jdk-#{version}" do
      let(:app) { Hatchet::Runner.new("clojure-minimal") }
      let(:jdk_version) { version }
      it "deploy successfully" do
        app.deploy do |app|
          expect(app.output).to include("Installing OpenJDK #{jdk_version}")
          expect(app.output).to match(/Downloading: leiningen-2.5.[0-9]-standalone.jar/)
          expect(app.output).to include("Running: lein uberjar")
          expect(app).to be_deployed
          expect(successful_body(app)).to include('["Hello" :from Heroku]')
        end
      end
    end
  end
end
