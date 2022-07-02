#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec sidekiq -d # run as a daemon and that's it.
bundle exec rails s -b 0.0.0.0