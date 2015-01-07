# encoding: utf-8
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.command_name 'rspec'
SimpleCov.start

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test, :development

require 'geo_pattern'

# Loading support files
Dir.glob(::File.expand_path('../support/*.rb', __FILE__)).each { |f| require_relative f }
Dir.glob(::File.expand_path('../shared_examples/*.rb', __FILE__)).each { |f| require_relative f }
