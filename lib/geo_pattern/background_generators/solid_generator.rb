module GeoPattern
  module BackgroundGenerators
    class SolidGenerator
      include Roles::NamedGenerator

      private

      attr_reader :color, :seed, :preset

      public

      def initialize(seed, preset)
        @color  = color_for(seed, preset)
        @preset = preset
      end

      def generate(pattern)
        pattern.background = Background.new(image: generate_background, preset: preset, color: color)

        self
      end

      private

      def generate_background
        svg = SvgImage.new
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
