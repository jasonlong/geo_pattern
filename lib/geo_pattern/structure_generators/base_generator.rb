module GeoPattern
  module StructureGenerators
    class BaseGenerator
      attr_reader :svg, :hash, :fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max

      def initialize(svg = SVG.new, hash, preset)
        @svg  = svg
        @hash = hash

        @fill_color_dark  = preset.fill_color_dark
        @fill_color_light = preset.fill_color_light
        @stroke_color     = preset.stroke_color
        @stroke_opacity   = preset.stroke_opacity
        @opacity_min      = preset.opacity_min
        @opacity_max      = preset.opacity_max
      end

      # Public: mutate the given `svg` object with a rendered pattern
      #
      # Note: this method _must_ be implemented by sub-
      # classes.
      #
      # svg - the SVG container
      #
      # Returns a reference to the same `svg` object
      # only this time with more patterns.
      def generate
        raise NotImplementedError
      end

      def hex_val(index, len)
        PatternHelpers.hex_val(hash, index, len)
      end

      def fill_color(val)
        (val.even?) ? fill_color_light : fill_color_dark
      end

      def opacity(val)
        map(val, 0, 15, opacity_min, opacity_max)
      end

      def map(value, v_min, v_max, d_min, d_max)
        PatternHelpers.map(value, v_min, v_max, d_min, d_max)
      end

      protected

      def build_plus_shape(square_size)
        [
          "rect(#{square_size},0,#{square_size},#{square_size * 3})",
          "rect(0, #{square_size},#{square_size * 3},#{square_size})"
        ]
      end
    end
  end
end
