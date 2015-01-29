$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'rubocop/rake_task'
require 'inch/rake'
require 'rspec/core/rake_task'
require 'geo_pattern/geo_pattern_task'

desc 'Default task running Tests'
task default: :test

desc 'Run test suite'
task test: ['test:rubocop', 'test:rspec']
task 'test:ci' => ['bootstrap:gem_requirements', :test]
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
      'fixtures/generated_patterns/octagons.svg'            => [string, :octagons],
      'fixtures/generated_patterns/overlapping_circles.svg' => [string, :overlapping_circles],
      'fixtures/generated_patterns/plus_signs.svg'          => [string, :plus_signs],
      'fixtures/generated_patterns/xes.svg'                 => [string, :xes],
      'fixtures/generated_patterns/sine_waves.svg'          => [string, :sine_waves],
      'fixtures/generated_patterns/hexagons.svg'            => [string, :hexagons],
      'fixtures/generated_patterns/overlapping_rings.svg'   => [string, :overlapping_rings],
      'fixtures/generated_patterns/plaid.svg'               => [string, :plaid],
      'fixtures/generated_patterns/triangles.svg'           => [string, :triangles],
      'fixtures/generated_patterns/squares.svg'             => [string, :squares],
      'fixtures/generated_patterns/nested_squares.svg'      => [string, :nested_squares],
      'fixtures/generated_patterns/mosaic_squares.svg'      => [string, :mosaic_squares],
      'fixtures/generated_patterns/concentric_circles.svg'  => [string, :concentric_circles],
      'fixtures/generated_patterns/diamonds.svg'            => [string, :diamonds],
      'fixtures/generated_patterns/tessellation.svg'        => [string, :tessellation]
    }
  )
end

desc 'Bootstrap project'
task bootstrap: %w(bootstrap:bundler)

desc 'Bootstrap project for ci'
task 'bootstrap:ci' do
  Rake::Task['bootstrap'].invoke
end

namespace :bootstrap do
  desc 'Bootstrap bundler'
  task :bundler do |t|
    puts t.comment
    sh 'gem install bundler'
    sh 'bundle install'
  end

  desc 'Require gems'
  task :gem_requirements do |t|
    puts t.comment
    require 'bundler'
    Bundler.require
  end
end
