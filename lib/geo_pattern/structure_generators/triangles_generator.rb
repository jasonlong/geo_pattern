module GeoPattern
  module StructureGenerators
    class TrianglesGenerator < BaseGenerator
      private

      attr_reader :scale, :side_length, :triangle_height, :triangle

      def after_initialize
        @scale           = hex_val(0, 1)
        @side_length     = map(scale, 0, 15, 15, 80)
        @triangle_height = side_length / 2 * Math.sqrt(3)
        @triangle        = build_triangle_shape(side_length, triangle_height)

        self.width  = side_length * 3
        self.height = triangle_height * 6
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

            rotation = if y % 2 == 0
                         x % 2 == 0 ? 180 : 0
                       else
                         x % 2 != 0 ? 180 : 0
                       end

            svg.polyline(triangle, styles.merge(
                                     'transform' => "translate(#{x * side_length * 0.5 - side_length / 2}, #{triangle_height * y}) rotate(#{rotation}, #{side_length / 2}, #{triangle_height / 2})"))

            # Add an extra one at top-right, for tiling.
            if x == 0
              svg.polyline(triangle, styles.merge(
                                       'transform' => "translate(#{6 * side_length * 0.5 - side_length / 2}, #{triangle_height * y}) rotate(#{rotation}, #{side_length / 2}, #{triangle_height / 2})"))
            end
            i += 1
          end
        end

        svg
      end

      def build_triangle_shape(side_length, height)
        half_width = side_length / 2
        "#{half_width}, 0, #{side_length}, #{height}, 0, #{height}, #{half_width}, 0"
      end
    end
  end
end
