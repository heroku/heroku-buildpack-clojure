#!/bin/bash

set -e

LEIN_VERSION=${1}
LEIN_FILE="/tmp/leiningen-$LEIN_VERSION-standalone.jar"

echo "---> Downloading Leiningen version $LEIN_VERSION..."
curl -o $LEIN_FILE --location https://github.com/technomancy/leiningen/releases/download/$LEIN_VERSION/leiningen-$LEIN_VERSION-standalone.zip

echo "---> Uploading leiningen-$LEIN_VERSION-standalone.jar to S3"
aws s3 cp $LEIN_FILE s3://lang-jvm --profile lang-jvm --acl public-read
rm $LEIN_FILE
