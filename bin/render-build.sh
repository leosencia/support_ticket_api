#!/usr/bin/env bash
set -o errexit

bundle install
bin/rails assets:precompile
bin/rails assets:clean

# bundle exec rails db:migrate
# bundle exec rails db:seed