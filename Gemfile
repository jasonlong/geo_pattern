source 'https://rubygems.org'

# Specify your gem's dependencies in geopatterns.gemspec
gemspec

group :development, :test do
  gem 'rspec'
  gem 'aruba'
  gem 'rake'
  gem 'rubocop'
  gem 'simplecov'
  gem 'fuubar'
  gem 'inch'
  gem 'activesupport', '~> 4.2', '>= 4.2.7.1'
  gem 'pry'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'

  if RUBY_VERSION >= '2'
    gem 'byebug'
    gem 'pry-byebug'
  else
    gem 'debugger'
    gem 'pry-debugger'
  end
end
