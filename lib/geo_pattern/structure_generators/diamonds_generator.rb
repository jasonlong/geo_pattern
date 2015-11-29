module GeoPattern
  module StructureGenerators
    class DiamondsGenerator < BaseGenerator
      private

      attr_reader :diamond_height, :diamond_width, :diamond

      def after_initialize
        @diamond_width  = map(hex_val(0, 1), 0, 15, 10, 50)
        @diamond_height = map(hex_val(1, 1), 0, 15, 10, 50)
        @diamond        = build_diamond_shape(diamond_width, diamond_height)

        self.height = diamond_height * 3
        self.width  = diamond_width * 6
      end

      def generate_structure
        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            styles = {
              'fill'           => fill,
              'fill-opacity'   => opacity,
              'stroke'         => stroke_color,
              'stroke-opacity' => stroke_opacity
            }

            dx = (y % 2 == 0) ? 0 : diamond_width / 2

            svg.polyline(diamond, styles.merge(
                                    'transform' => "translate(#{x * diamond_width - diamond_width / 2 + dx}, #{diamond_height / 2 * y - diamond_height / 2})"))

            # Add an extra one at top-right, for tiling.
            if x == 0
              svg.polyline(diamond, styles.merge(
                                      'transform' => "translate(#{6 * diamond_width - diamond_width / 2 + dx}, #{diamond_height / 2 * y - diamond_height / 2})"))
            end

            # Add an extra row at the end that matches the first row, for tiling.
            if y == 0
              svg.polyline(diamond, styles.merge(
                                      'transform' => "translate(#{x * diamond_width - diamond_width / 2 + dx}, #{diamond_height / 2 * 6 - diamond_height / 2})"))
            end

            # Add an extra one at bottom-right, for tiling.
            if x == 0 && y == 0
              svg.polyline(diamond, styles.merge(
                                      'transform' => "translate(#{6 * diamond_width - diamond_width / 2 + dx}, #{diamond_height / 2 * 6 - diamond_height / 2})"))
            end
            i += 1
          end
        end

        svg
      end

      def build_diamond_shape(width, height)
        "#{width / 2}, 0, #{width}, #{height / 2}, #{width / 2}, #{height}, 0, #{height / 2}"
      end
    end
  end
end
