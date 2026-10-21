# frozen_string_literal: true

source "https://rubygems.org"

# Specify the gem's runtime dependencies in geo_pattern.gemspec
gemspec

# Allows CI to test against each supported major version of color
gem "color", ENV["COLOR_VERSION"] if ENV["COLOR_VERSION"]

group :development, :test do
  gem "aruba", "~> 2.0"
  gem "fuubar"
  gem "pry", require: false
  gem "rspec"
  gem "standard", require: false
  gem "simplecov", "~> 1.3", require: false
end
