source 'https://rubygems.org'

# Specify your gem's dependencies in geopatterns.gemspec
gemspec

group :development, :test do
  gem 'rspec', require: false
  gem 'aruba', require: false, git: 'https://github.com/cucumber/aruba.git'
  gem 'rake', require: false
  gem 'rubocop', require: false
  gem 'simplecov', require: false
  gem 'fuubar', require: false
  gem 'inch', require: false
  gem 'activesupport', require: false
  gem 'cucumber', require: false
  gem 'pry'

  if RUBY_VERSION >= "2"
    gem 'byebug'
    gem 'pry-byebug'
  else
    gem 'debugger'
    gem 'pry-debugger'
  end
end
