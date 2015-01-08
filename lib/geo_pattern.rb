require 'base64'
require 'digest/sha1'
require 'color'

require 'geo_pattern/version'
require 'geo_pattern/svg'
require 'geo_pattern/pattern_helpers'
require 'geo_pattern/pattern_db'

require 'geo_pattern/pattern/base_pattern'
require 'geo_pattern/pattern/chevron_pattern'
require 'geo_pattern/pattern/concentric_circles_pattern'
require 'geo_pattern/pattern/diamond_pattern'
require 'geo_pattern/pattern/hexagon_pattern'
require 'geo_pattern/pattern/mosaic_squares_pattern'
require 'geo_pattern/pattern/nested_squares_pattern'
require 'geo_pattern/pattern/octagon_pattern'
require 'geo_pattern/pattern/overlapping_circles_pattern'
require 'geo_pattern/pattern/overlapping_rings_pattern'
require 'geo_pattern/pattern/plaid_pattern'
require 'geo_pattern/pattern/plus_sign_pattern'
require 'geo_pattern/pattern/sine_wave_pattern'
require 'geo_pattern/pattern/square_pattern'
require 'geo_pattern/pattern/tessellation_pattern'
require 'geo_pattern/pattern/triangle_pattern'
require 'geo_pattern/pattern/xes_pattern'

require 'geo_pattern/pattern_generator'

module GeoPattern
  def self.generate(string=Time.now, opts={})
    GeoPattern::PatternGenerator.new(string.to_s, opts)
  end
end
