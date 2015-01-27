$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'rubocop/rake_task'
require 'inch/rake'
require 'rspec/core/rake_task'
require 'geo_pattern/geo_pattern_task'

desc 'Default task running Tests'
task default: :test

desc 'Run test suite'
task test: 'test:rspec'
# task test: %w(test:rspec test:rubocop)

namespace :test do

  RSpec::Core::RakeTask.new(:rspec)

  RuboCop::RakeTask.new

  Inch::Rake::Suggest.new
end

namespace :gem do
  require 'bundler/gem_tasks'
end

namespace :fixtures do
  string = 'Master Markdown'

  GeoPattern::GeoPatternTask.new(
    name: 'generate',
    description: 'Generate patterns to make them available as fixtures',
    data: {
      'fixtures/sine_waves.svg' => string
    }
  )
end
