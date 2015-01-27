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
      'fixtures/octagons.svg'            => [string, :octagons],
      'fixtures/overlapping_circles.svg' => [string, :overlapping_circles],
      'fixtures/plus_signs.svg'          => [string, :plus_signs],
      'fixtures/xes.svg'                 => [string, :xes],
      'fixtures/sine_waves.svg'          => [string, :sine_waves],
      'fixtures/hexagons.svg'            => [string, :hexagons],
      'fixtures/overlapping_rings.svg'   => [string, :overlapping_rings],
      'fixtures/plaid.svg'               => [string, :plaid],
      'fixtures/triangles.svg'           => [string, :triangles],
      'fixtures/squares.svg'             => [string, :squares],
      'fixtures/nested_squares.svg'      => [string, :nested_squares],
      'fixtures/mosaic_squares.svg'      => [string, :mosaic_squares],
      'fixtures/concentric_circles.svg'  => [string, :concentric_circles],
      'fixtures/diamonds.svg'            => [string, :diamonds],
      'fixtures/tessellation.svg'        => [string, :tessellation]
    }
  )
end
