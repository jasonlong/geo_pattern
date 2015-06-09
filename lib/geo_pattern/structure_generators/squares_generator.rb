module GeoPattern
  module StructureGenerators
    class SquaresGenerator < BaseGenerator
      private

      attr_reader :square_size

      def after_initialize
        @square_size = map(hex_val(0, 1), 0, 15, 10, 60)

        self.height = self.width = square_size * 6
      end

      def generate_structure
        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            svg.rect(x * square_size, y * square_size, square_size, square_size,
                     'fill'           => fill,
                     'fill-opacity'   => opacity,
                     'stroke'         => stroke_color,
                     'stroke-opacity' => stroke_opacity
                    )
            i += 1
          end
        end

        svg
      end
    end
  end
end
