#!/usr/bin/env bash
# Render / CI build for this API-only app.
#
# Never run bare `rails` here — Bundler’s shim (~/.gems/bin/rails) can fail with:
#   Gem::GemNotFoundException: can't find gem railties ... (executable rails)
# Always use `bundle exec rails` or `./bin/rails` (project binstub loads config/boot).
#
# Migrations: use Render “Pre-Deploy Command” or `preDeployCommand` in render.yaml,
# not the build phase. Seeds: run once via Render Shell (`bundle exec rails db:seed`).
set -o errexit

bundle install
bundle exec rails db:migrate
bundle exec rails db:seed