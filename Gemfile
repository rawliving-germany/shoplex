# frozen_string_literal: true

ruby "3.2.1" # for CI to work, needs to match .github/workflows/ruby.yml

source "https://rubygems.org"

# Specify your gem's dependencies in shoplex.gemspec
gemspec

# Test and Gem maintenance

gem "rake", "~> 13.0"
gem "minitest", "~> 5.0"
gem "minitest-reporters", "~> 1.6"

# Webui

gem "sinatra", "~> 3.0"
gem "haml", "~> 6.1"
gem "puma", "~> 6.1"

gem "rerun", "~> 0.14.0"

gem "guard", "~> 2.18"

gem "guard-minitest", "~> 2.4"
