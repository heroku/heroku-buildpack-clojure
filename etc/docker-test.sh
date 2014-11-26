#!/bin/bash

DIR=$(cd $(dirname $0)/..; pwd)

docker run -it -v $DIR:/app/buildpack:ro heroku/testrunner
