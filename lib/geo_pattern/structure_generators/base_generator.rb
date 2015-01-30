module GeoPattern
  module StructureGenerators
    class BaseGenerator
      include Roles::NamedGenerator

      attr_reader :svg, :seed, :fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max, :preset

      def initialize(seed, preset, svg = SvgImage.new)
        @svg    = svg
        @seed   = seed
        @preset = preset

        @fill_color_dark  = @preset.fill_color_dark
        @fill_color_light = @preset.fill_color_light
        @stroke_color     = @preset.stroke_color
        @stroke_opacity   = @preset.stroke_opacity
        @opacity_min      = @preset.opacity_min
        @opacity_max      = @preset.opacity_max
      end

      def generate(pattern)
        pattern.structure = Structure.new(image: generate_structure, preset: preset, generator: self.class, name: name)

        self
      end

      private

      # Generate the structure
      def generate_structure
        fail NotImplementedError
      end

      def hex_val(index, len)
        seed.to_i(index, len)
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
