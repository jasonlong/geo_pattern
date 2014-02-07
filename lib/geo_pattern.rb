require "geo_pattern/version"
require "geo_pattern/svg"
require "geo_pattern/pattern"

module GeoPattern
  def self.generate(string=Time.now.to_s, opts={})
    GeoPattern::Pattern.new(string, opts)
  end
end
