#!/usr/bin/env bash
# Render build: install gems only. Do not run db:migrate here — DATABASE_URL may be
# unavailable during build on free tier; run migrations in Start Command instead.
#
# Never invoke bare `rails` from PATH; use `bundle exec` or `./bin/rails`.
set -o errexit

bundle install
bundle exec rails db:migrate
bundle exec rails db:seed