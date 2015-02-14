$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

desc 'Default task running Tests'
task default: :test

desc 'Run test suite'
task test: ['test:rubocop', 'test:rspec']
task 'test:ci' => ['bootstrap:gem_requirements', :test]
namespace :test do
  task :rspec do
    sh 'rspec'
  end

  task :rubocop do
    sh 'rubocop'
  end

  task 'rubocop:autocorrect' do
    sh 'rubocop --auto-correct'
  end

  task 'inch' do
    sh 'inch'
  end
end

namespace :gem do
  require 'bundler/gem_tasks'
end

unless ENV.key?('CI')
  require 'geo_pattern/geo_pattern_task'

  namespace :fixtures do
    string = 'Mastering Markdown'

    GeoPattern::GeoPatternTask.new(
      name: 'generate',
      description: 'Generate patterns to make them available as fixtures',
      data: {
        'fixtures/generated_patterns/chevrons.svg'                 => { input: string, patterns: [:chevrons] },
        'fixtures/generated_patterns/concentric_circles.svg'       => { input: string, patterns: [:concentric_circles] },
        'fixtures/generated_patterns/diamonds.svg'                 => { input: string, patterns: [:diamonds] },
        'fixtures/generated_patterns/hexagons.svg'                 => { input: string, patterns: [:hexagons] },
        'fixtures/generated_patterns/mosaic_squares.svg'           => { input: string, patterns: [:mosaic_squares] },
        'fixtures/generated_patterns/nested_squares.svg'           => { input: string, patterns: [:nested_squares] },
        'fixtures/generated_patterns/octagons.svg'                 => { input: string, patterns: [:octagons] },
        'fixtures/generated_patterns/overlapping_circles.svg'      => { input: string, patterns: [:overlapping_circles] },
        'fixtures/generated_patterns/overlapping_rings.svg'        => { input: string, patterns: [:overlapping_rings] },
        'fixtures/generated_patterns/plaid.svg'                    => { input: string, patterns: [:plaid] },
        'fixtures/generated_patterns/plus_signs.svg'               => { input: string, patterns: [:plus_signs] },
        'fixtures/generated_patterns/sine_waves.svg'               => { input: string, patterns: [:sine_waves] },
        'fixtures/generated_patterns/squares.svg'                  => { input: string, patterns: [:squares] },
        'fixtures/generated_patterns/tessellation.svg'             => { input: string, patterns: [:tessellation] },
        'fixtures/generated_patterns/triangles.svg'                => { input: string, patterns: [:triangles] },
        'fixtures/generated_patterns/xes.svg'                      => { input: string, patterns: [:xes] },
        'fixtures/generated_patterns/diamonds_with_color.svg'      => { input: string, patterns: [:diamonds], color: '#00ff00' },
        'fixtures/generated_patterns/diamonds_with_base_color.svg' => { input: string, patterns: [:diamonds], base_color: '#00ff00' }
      }
    )
  end
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
