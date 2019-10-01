#!/bin/sh
set -e

# re-run bundler install to capture new Gemfile changes
bundle config build.nokogiri --use-system-libraries
bundle install --jobs 4 --retry 5

exec "$@"
