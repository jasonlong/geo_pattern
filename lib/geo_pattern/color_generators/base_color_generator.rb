# frozen_string_literal: true

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
        @color = color
        @seed = seed
        @creator = creator
      end

      # Generator color
      def generate
        creator.new(transform(color, seed))
      end

      private

      def transform(color, seed)
        hue_offset = map(seed.to_i(14, 3), 0, 4095, 0, 359)
        sat_offset = seed.to_i(17, 1)

        PatternHelpers.offset_color(color, hue_offset, sat_offset).html
      end

      # Ruby implementation of Processing's map function
      # http://processing.org/reference/map_.html
      # v for value, d for desired
      def map(value, v_min, v_max, d_min, d_max)
        v_value = value.to_f # so it returns float

        v_range = v_max - v_min
        d_range = d_max - d_min
        (v_value - v_min) * d_range / v_range + d_min
      end
    end
  end
end
