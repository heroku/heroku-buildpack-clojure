#!/usr/bin/env bash

if [ -n "`git config --get user.email`" ]; then
  echo 'already set'; else `git config --global user.email 'buildpack@example.com'`
fi
if [ -n "`git config --get user.name`" ]; then
  echo 'already set'; else `git config --global user.name 'BuildpackTester'`
fi

cat <<EOF
EOF > ~/.ssh/config
Host heroku.com
    StrictHostKeyChecking no
    CheckHostIP no
    UserKnownHostsFile=/dev/null
Host github.com
    StrictHostKeyChecking no
EOF

yes | heroku keys:add

gem install heroku_hatchet
gem install rspec-retry
gem install rspec-expectations

hatchet install &&
HATCHET_RETRIES=3 \
HATCHET_DEPLOY_STRATEGY=git \
HATCHET_BUILDPACK_BASE="https://github.com/heroku/heroku-buildpack-clojure.git" \
HATCHET_BUILDPACK_BRANCH=$(git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#\1#') \
rspec spec/
