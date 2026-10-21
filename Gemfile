# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in geopatterns.gemspec
gemspec

# Allows CI to test against each supported major version of color
gem "color", ENV["COLOR_VERSION"] if ENV["COLOR_VERSION"]

group :development, :test do
  gem "activesupport", "~> 6"
  gem "aruba", "~> 2.0"
  gem "fuubar"
  gem "inch"
  gem "pry"
  gem "pry-rescue"
  gem "pry-stack_explorer"
  gem "rake"
  gem "rspec"
  gem "standard"
  gem "simplecov"

  gem "byebug"
  gem "irb"
  gem "pry-byebug"
end
