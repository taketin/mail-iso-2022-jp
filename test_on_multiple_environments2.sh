#!/bin/bash
#
# rbenv version

set -e

USING_EDGE_MAIL_GEM=true bundle update mail
USING_EDGE_MAIL_GEM=true bundle exec ruby -Itest test/mail_test.rb

function run {
  gem list --local bundler | grep bundler || gem install bundler --no-ri --no-rdoc

  for version in 3.0.17 3.1.8 3.2.8
  do
    echo "Running bundle exec rspec spec against rails $version..."
    MAIL_ISO_2022_JP_RAILS_VERSION=$version bundle update mail rails
    MAIL_ISO_2022_JP_RAILS_VERSION=$version bundle exec rake test
  done
}

export RBENV_VERSION=1.8.7-p358
run

export RBENV_VERSION=1.9.3-p286
run

echo 'Success!'
