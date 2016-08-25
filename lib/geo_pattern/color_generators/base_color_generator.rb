module GeoPattern
  # Color generators
  module ColorGenerators
    # Generate color based on Base Color and seed
    class BaseColorGenerator
      private

      attr_reader :creator, :seed, :color

      public

      # New
      #
      # @param [String] color
      #   HTML color string, #0a0a0a
      def initialize(color, seed, creator = Color)
        @color   = color
        @seed    = seed
        @creator = creator
      end

      # Generator color
      def generate
        creator.new(transform(color, seed))
      end

      private

      def transform(color, seed)
        hue_offset    = map(seed.to_i(14, 3), 0, 4095, 0, 359)
        sat_offset    = seed.to_i(17, 1)
        new_color     = ::Color::RGB.from_html(color).to_hsl
        new_color.hue = new_color.hue - hue_offset

        new_color.saturation = if sat_offset % 2 == 0
                                 new_color.saturation + sat_offset
                               else
                                 new_color.saturation - sat_offset
                               end
        new_color.html
      end

      # Ruby implementation of Processing's map function
      # http://processing.org/reference/map_.html
      def map(value, v_min, v_max, d_min, d_max) # v for value, d for desired
        v_value = value.to_f # so it returns float

        v_range = v_max - v_min
        d_range = d_max - d_min
        (v_value - v_min) * d_range / v_range + d_min
      end
    end
  end
end
