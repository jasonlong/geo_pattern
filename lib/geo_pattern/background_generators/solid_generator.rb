module GeoPattern
  # Generating backgrounds
  module BackgroundGenerators
    # Generating a solid background
    class SolidGenerator
      include Roles::NamedGenerator

      private

      attr_reader :color, :seed, :preset

      public

      # New generator
      #
      # @param [Seed] seed
      #   The seed used during generation the background
      #
      # @param [ColorPreset] preset
      #   A preset of values which are used during generating the background
      def initialize(seed, preset)
        @color  = color_for(seed, preset)
        @preset = preset
      end

      # Generate the background for pattern
      #
      # @param [#background=] pattern
      #   The pattern for which the background should be generated
      def generate(pattern)
        pattern.background = Background.new(image: generate_background, preset: preset, color: color, generator: self.class)

        self
      end

      private

      def generate_background
        svg = SvgImage.new
        svg.rect(0, 0, '100%', '100%', 'fill' => color.to_svg)

        svg
      end

      def color_for(seed, preset)
        return ColorGenerators::BaseColorGenerator.new(preset.base_color, seed).generate if preset.mode? :base_color

        ColorGenerators::SimpleGenerator.new(preset.color).generate
      end
    end
  end
end
