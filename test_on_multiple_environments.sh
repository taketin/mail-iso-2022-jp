#!/bin/bash
#
# rbenv version

set -e

function run {
  for version in 2.2.6 2.4.4 2.5.3
  do
    MAIL_GEM_VERSION=$version bundle update mail
    MAIL_GEM_VERSION=$version bundle exec ruby -Itest test/mail_test.rb
  done

  gem list --local bundler | grep bundler || gem install bundler --no-ri --no-rdoc

  for version in 3.0.17 3.1.8 3.2.9
  do
    echo "Running bundle exec rspec spec against rails $version..."
    MAIL_ISO_2022_JP_RAILS_VERSION=$version bundle update mail rails
    MAIL_ISO_2022_JP_RAILS_VERSION=$version bundle exec rake test
  done
}

export RBENV_VERSION=1.8.7-p358
run

export RBENV_VERSION=1.9.3-p327
run

export RBENV_VERSION=2.0.0-preview2
run

echo 'Success!'
