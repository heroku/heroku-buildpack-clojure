#!/bin/bash

set -e

BP_NAMESPACE="heroku"
BP_NAME="clojure"

BP_VERSION=${1:?}

pushd . > /dev/null 2>&1
cd /tmp
rm -rf heroku-buildpack-$BP_NAME
git clone git@github.com:heroku/heroku-buildpack-$BP_NAME.git
cd heroku-buildpack-$BP_NAME
git checkout master

headHash=$(git rev-parse HEAD)
echo "Tagging commit $headHash with $BP_VERSION... "
git tag $BP_VERSION
git push --tags

heroku buildpacks:publish $BP_NAMESPACE/$BP_NAME $BP_VERSION

echo "Updating previous-version tag"
git tag -d previous-version
git push origin :previous-version
git tag previous-version latest-version
echo "Updating latest-version tag"
git tag -d latest-version
git push origin :latest-version
git tag latest-version
git push --tags

echo "Done."
