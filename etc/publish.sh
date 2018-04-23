#!/bin/bash

set -e

BP_VERSION=${1:?}
BP_NAME=${2:-"heroku/clojure"}

originMaster=$(git rev-parse origin/master)
echo "Tagging commit $originMaster with $BP_VERSION... "
git tag $BP_VERSION ${originMaster:?}
git push --tags

heroku buildpacks:publish $BP_NAME $BP_VERSION

echo "Updating previous-version tag"
git tag -d previous-version
git push origin :previous-version
git tag previous-version latest-version
echo "Updating latest-version tag"
git tag -d latest-version
git push origin :latest-version
git tag latest-version ${originMaster:?}
git push --tags

echo "Done."
