module GeoPattern
  module StructureGenerators
    class OverlappingCirclesGenerator < BaseGenerator
      private

      attr_reader :scale, :diameter, :radius

      def after_initialize
        @scale    = hex_val(0, 1)
        @diameter = map(scale, 0, 15, 25, 200)
        @radius   = diameter / 2

        self.height = self.width = radius * 6
      end

      def generate_structure
        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            styles = {
              'fill'  => fill,
              'style' => {
                'opacity' => opacity
              }
            }

            svg.circle(x * radius, y * radius, radius, styles)

            # Add an extra one at top-right, for tiling.
            if x == 0
              svg.circle(6 * radius, y * radius, radius, styles)
            end

            # Add an extra row at the end that matches the first row, for tiling.
            if y == 0
              svg.circle(x * radius, 6 * radius, radius, styles)
            end

            # Add an extra one at bottom-right, for tiling.
            if x == 0 && y == 0
              svg.circle(6 * radius, 6 * radius, radius, styles)
            end
            i += 1
          end
        end

        svg
      end
    end
  end
end
