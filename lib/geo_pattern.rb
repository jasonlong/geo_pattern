require "geo_pattern/version"
require "geo_pattern/svg"
require "geo_pattern/pattern_generator"

module GeoPattern
  def self.generate(string=Time.now.to_s, opts={})
    GeoPattern::PatternGenerator.new(string, opts)
  end
end
