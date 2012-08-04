#!/bin/bash

set -e

USING_EDGE_MAIL_GEM=true bundle update mail
USING_EDGE_MAIL_GEM=true bundle exec ruby -Itest test/mail_test.rb

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
  source "/usr/local/rvm/scripts/rvm"
else
  printf "ERROR: An RVM installation was not found.\n"
fi

function run {
  gem list --local bundler | grep bundler || gem install bundler --no-ri --no-rdoc

  for version in 3.0.16 3.1.7 3.2.8.rc2
  do
    echo "Running bundle exec rspec spec against rails $version..."
    MAIL_ISO_2022_JP_RAILS_VERSION=$version bundle update mail rails
    MAIL_ISO_2022_JP_RAILS_VERSION=$version bundle exec rake test
  done
}

rvm use ruby-1.8.7@mail-iso-2022-jp --create
run

rvm use ruby-1.9.3@mail-iso-2022-jp --create
run

echo 'Success!'
