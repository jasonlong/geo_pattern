require 'base64'
require 'digest/sha1'
require 'color'
require 'forwardable'

require 'geo_pattern/version'

require 'geo_pattern/roles/named_generator'
require 'geo_pattern/roles/comparable_metadata'

require 'geo_pattern/errors'
require 'geo_pattern/color'
require 'geo_pattern/svg_image'
require 'geo_pattern/pattern_helpers'
require 'geo_pattern/helpers'
require 'geo_pattern/pattern_store'
require 'geo_pattern/pattern_validator'
require 'geo_pattern/pattern_sieve'
require 'geo_pattern/pattern'
require 'geo_pattern/seed'
require 'geo_pattern/pattern_preset'
require 'geo_pattern/color_preset'

require 'geo_pattern/structure'
require 'geo_pattern/background'

require 'geo_pattern/color_generators/simple_generator'
require 'geo_pattern/color_generators/base_color_generator'

require 'geo_pattern/background_generators/solid_generator'

require 'geo_pattern/structure_generators/base_generator'
require 'geo_pattern/structure_generators/chevrons_generator'
require 'geo_pattern/structure_generators/concentric_circles_generator'
require 'geo_pattern/structure_generators/diamonds_generator'
require 'geo_pattern/structure_generators/hexagons_generator'
require 'geo_pattern/structure_generators/mosaic_squares_generator'
require 'geo_pattern/structure_generators/nested_squares_generator'
require 'geo_pattern/structure_generators/octagons_generator'
require 'geo_pattern/structure_generators/overlapping_circles_generator'
require 'geo_pattern/structure_generators/overlapping_rings_generator'
require 'geo_pattern/structure_generators/plaid_generator'
require 'geo_pattern/structure_generators/plus_signs_generator'
require 'geo_pattern/structure_generators/sine_waves_generator'
require 'geo_pattern/structure_generators/squares_generator'
require 'geo_pattern/structure_generators/tessellation_generator'
require 'geo_pattern/structure_generators/triangles_generator'
require 'geo_pattern/structure_generators/xes_generator'

require 'geo_pattern/pattern_generator'

module GeoPattern
  def self.generate(string = Time.now, opts = {})
    GeoPattern::PatternGenerator.new(string.to_s, opts).generate
  end
end
