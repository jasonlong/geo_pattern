require 'bundler/gem_tasks'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: :test

task test: 'test:rspec'
# task test: %w(test:rspec test:rubocop)

namespace :test do
  task :rspec do
    sh 'bundle exec rspec'
  end

  task :rubocop do
    sh 'bundle exec rubocop'
  end
end
