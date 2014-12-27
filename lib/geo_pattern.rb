require "geo_pattern/version"
require "geo_pattern/svg"
require 'geo_pattern/pattern/pattern_helpers'
require "geo_pattern/pattern_generator"

module GeoPattern
  def self.generate(string=Time.now, opts={})
    GeoPattern::PatternGenerator.new(string.to_s, opts)
  end
end
