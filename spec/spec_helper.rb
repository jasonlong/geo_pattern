# frozen_string_literal: true

$LOAD_PATH << File.expand_path("../lib", __dir__)

require "simplecov"
SimpleCov.command_name "rspec"
SimpleCov.start

# Pull in all of the gems including those in the `test` group
require "bundler"
Bundler.require :default, :test, :development

require "geo_pattern"

# Loading support files
GeoPattern::Helpers.require_files_matching_pattern ::File.expand_path("support/**/*.rb", __dir__)

# No need to add the namespace to every class tested
include GeoPattern # rubocop:disable Style/MixinUsage
