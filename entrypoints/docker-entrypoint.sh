#!/bin/sh

set -e

export RAILS_ENV=production

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# prepare rails db
bundle exec rails db:prepare

bundle exec sidekiq -d --environment production # run as a daemon and that's it.
bundle exec rails s -b 0.0.0.0
