#!/bin/bash

set -e

LEIN_VERSION=${1}
LEIN_FILE="/tmp/leiningen-$LEIN_VERSION-standalone.jar"

echo "---> Downloading Leiningen version $LEIN_VERSION..."
curl -o $LEIN_FILE --location https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip

echo "---> Uploading leiningen-$LEIN_VERSION-standalone.jar to S3"
aws s3 cp $LEIN_FILE s3://heroku-buildpack-clojure --profile clojure --acl public-read
rm $LEIN_FILE

echo "---> Updating scripts..."
CUR_VERSION="$(grep "LEIN_VERSION=\"2" bin/compile | sed -E -e 's/LEIN_VERSION=//g' | sed 's/[" ]//g')"
sed -e s/${CUR_VERSION}/${LEIN_VERSION}/g bin/compile > bin/compile.tmp
mv bin/compile.tmp bin/compile
chmod +x bin/compile

echo "---> WARNING: Update test files manually!"
grep -nr "$CUR_VERSION" .
