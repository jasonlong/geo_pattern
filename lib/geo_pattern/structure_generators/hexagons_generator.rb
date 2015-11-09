module GeoPattern
  module StructureGenerators
    class HexagonsGenerator < BaseGenerator
      private

      attr_reader :scale, :side_length, :hex_height, :hex_width, :hex

      def after_initialize
        @scale       = hex_val(0, 1)
        @side_length = map(scale, 0, 15, 8, 60)
        @hex_height  = side_length * Math.sqrt(3)
        @hex_width   = side_length * 2
        @hex         = build_hexagon_shape(side_length)

        self.width  = hex_width * 3 + side_length * 3
        self.height = hex_height * 6
      end

      def generate_structure
        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            dy      = x % 2 == 0 ? y * hex_height : y * hex_height + hex_height / 2
            opacity = opacity(val)
            fill    = fill_color(val)

            styles = {
              'fill'           => fill,
              'fill-opacity'   => opacity,
              'stroke'         => stroke_color,
              'stroke-opacity' => stroke_opacity
            }

            svg.polyline(hex, styles.merge('transform' => "translate(#{x * side_length * 1.5 - hex_width / 2}, #{dy - hex_height / 2})"))

            # Add an extra one at top-right, for tiling.
            if x == 0
              svg.polyline(hex, styles.merge('transform' => "translate(#{6 * side_length * 1.5 - hex_width / 2}, #{dy - hex_height / 2})"))
            end

            # Add an extra row at the end that matches the first row, for tiling.
            if y == 0
              dy = x % 2 == 0 ? 6 * hex_height : 6 * hex_height + hex_height / 2
              svg.polyline(hex, styles.merge('transform' => "translate(#{x * side_length * 1.5 - hex_width / 2}, #{dy - hex_height / 2})"))
            end

            # Add an extra one at bottom-right, for tiling.
            if x == 0 && y == 0
              svg.polyline(hex, styles.merge('transform' => "translate(#{6 * side_length * 1.5 - hex_width / 2}, #{5 * hex_height + hex_height / 2})"))
            end
            i += 1
          end
        end

        svg
      end

      def build_hexagon_shape(side_length)
        c = side_length
        a = c / 2
        b = Math.sin(60 * Math::PI / 180) * c
        "0,#{b},#{a},0,#{a + c},0,#{2 * c},#{b},#{a + c},#{2 * b},#{a},#{2 * b},0,#{b}"
      end
    end
  end
end
