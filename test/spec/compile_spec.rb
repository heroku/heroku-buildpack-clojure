require_relative "spec_helper"

describe "Heroku's Clojure Support" do

  it "compiles a project without min-lein-version with JDK 1.7" do
    new_default_hatchet_runner("test/spec/fixtures/repos/lein-1-jdk-7").tap do |app|
      app.deploy do
        expect(app.output).to include("Installing JDK 1.7... done")
        expect(app.output).to include("No :min-lein-version found in project.clj; using 1.7.1.")
        expect(app.output).to include("To use Leiningen 2.x, add this to project.clj: :min-lein-version \"2.0.0\"")
        expect(app.output).to include("Downloading: leiningen-1.7.1-standalone.jar")
      end
    end
  end

  it "compiles a project without :min-lein-version with the default JDK version" do
    new_default_hatchet_runner("test/spec/fixtures/repos/lein-1-jdk-8").tap do |app|
      app.deploy do
        expect(app.output).to include("Installing JDK 1.8... done")
        expect(app.output).to include("No :min-lein-version found in project.clj; using 1.7.1.")
        expect(app.output).to include("To use Leiningen 2.x, add this to project.clj: :min-lein-version \"2.0.0\"")
        expect(app.output).to include("Downloading: leiningen-1.7.1-standalone.jar")
      end
    end
  end

  it "compiles a project with :min-lein-version set to 2.0.0 with the default JDK version" do
    new_default_hatchet_runner("test/spec/fixtures/repos/lein-2-jdk-8").tap do |app|
      app.deploy do
        expect(app.output).to include("Installing JDK 1.8... done")
        expect(app.output).to include("Downloading: leiningen-2.9.1-standalone.jar")
        expect(app.output).not_to include("WARNING: no :min-lein-version found in project.clj; using 1.7.1.")
      end
    end
  end

  it "runs `lein uberjar` when the project has a :uberjar-name setting" do
    new_default_hatchet_runner("test/spec/fixtures/repos/lein-2-jdk-8-uberjar").tap do |app|
      app.deploy do
        expect(app.output).to include("Installing JDK 1.8... done")
        expect(app.output).to include("Running: lein uberjar")
      end
    end
  end

  it "uses a cached Leiningen for subsequent builds" do
    new_default_hatchet_runner("test/spec/fixtures/repos/lein-1-jdk-7").tap do |app|
      app.deploy do
        expect(app.output).not_to include("Using cached Leiningen")

        app.commit!
        app.push!

        expect(app.output).to include("Using cached Leiningen")
      end
    end
  end
end
