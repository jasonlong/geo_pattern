module GeoPattern
  module BackgroundGenerators
    class SolidGenerator
      private

      attr_reader :color, :seed

      public

      def initialize(seed, preset)
        @color = color_for(seed, preset)
      end

      def generate(pattern)
        pattern.add_background generate_background
      end

      private

      def generate_background
        svg   = SVG.new
        svg.rect(0, 0, "100%", "100%", "fill" => color)

        svg
      end

      def color_for(seed, preset)
        return PatternHelpers.html_to_rgb(preset.color) if preset.color?

        PatternHelpers.html_to_rgb_for_string(seed, preset.base_color)
      end
    end
  end
end
