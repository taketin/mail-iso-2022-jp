#!/bin/bash
#
# rbenv version

set -e

for version in 2.2.6 2.2.19 2.3.3 2.5.2
do
  MAIL_GEM_VERSION=$version bundle update mail
  MAIL_GEM_VERSION=$version bundle exec ruby -Itest test/mail_test.rb
done

function run {
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

export RBENV_VERSION=2.0.0-preview1
run

echo 'Success!'
