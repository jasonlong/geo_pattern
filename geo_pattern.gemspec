# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "geo_pattern/version"

Gem::Specification.new do |spec|
  spec.name = "geo_pattern"
  spec.version = GeoPattern::VERSION
  spec.authors = ["Jason Long"]
  spec.email = ["jason@jasonlong.me"]
  spec.summary = "Generate beautiful SVG patterns"
  spec.description = "Generate deterministic, tiling SVG patterns from a string."
  spec.homepage = "https://github.com/jasonlong/geo_pattern"
  spec.license = "MIT"

  spec.metadata = {
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md"
  }

  spec.files = Dir.glob("lib/**/*.rb") + %w[README.md LICENSE.txt CHANGELOG.md]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6"

  spec.add_dependency "base64", ">= 0.1"
  spec.add_dependency "color", ">= 1.5"
  spec.add_dependency "logger", ">= 1.4"
  spec.add_dependency "rake", ">= 12.0"
  spec.add_development_dependency "bundler", ">= 2.2"
end
