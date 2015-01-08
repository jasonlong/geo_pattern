# encoding: utf-8
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.command_name 'rspec'
SimpleCov.start

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test, :development

require 'geo_pattern'

# Make some helpers available
include GeoPattern::Helpers

# Loading support files
#::File.expand_path('../support/*.rb', __FILE__)
require_files_matching_pattern ::File.expand_path('../support/*.rb', __FILE__)
require_files_matching_pattern ::File.expand_path('../shared_examples/*.rb', __FILE__)

# No need to add the namespace to every class tested
include GeoPattern
