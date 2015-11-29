module GeoPattern
  module StructureGenerators
    class XesGenerator < BaseGenerator
      private

      attr_reader :square_size, :x_shape, :x_size

      def after_initialize
        @square_size = map(hex_val(0, 1), 0, 15, 10, 25)
        @x_shape     = build_plus_shape(square_size) # rotated later
        @x_size      = square_size * 3 * 0.943

        self.height = self.width = x_size * 3
      end

      def generate_structure
        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            dy      = x % 2 == 0 ? y * x_size - x_size * 0.5 : y * x_size - x_size * 0.5 + x_size / 4
            fill    = fill_color(val)

            styles = {
              'fill'  => fill,
              'style' => {
                'opacity' => opacity
              }
            }

            svg.group(x_shape, styles.merge(
                                 'transform' => "translate(#{x * x_size / 2 - x_size / 2},#{dy - y * x_size / 2}) rotate(45, #{x_size / 2}, #{x_size / 2})"))

            # Add an extra column on the right for tiling.
            if x == 0
              svg.group(x_shape, styles.merge(
                                   'transform' => "translate(#{6 * x_size / 2 - x_size / 2},#{dy - y * x_size / 2}) rotate(45, #{x_size / 2}, #{x_size / 2})"))
            end

            # Add an extra row on the bottom that matches the first row, for tiling.
            if y == 0
              dy = x % 2 == 0 ? 6 * x_size - x_size / 2 : 6 * x_size - x_size / 2 + x_size / 4
              svg.group(x_shape, styles.merge(
                                   'transform' => "translate(#{x * x_size / 2 - x_size / 2},#{dy - 6 * x_size / 2}) rotate(45, #{x_size / 2}, #{x_size / 2})"))
            end

            # These can hang off the bottom, so put a row at the top for tiling.
            if y == 5
              svg.group(x_shape, styles.merge(
                                   'transform' => "translate(#{x * x_size / 2 - x_size / 2},#{dy - 11 * x_size / 2}) rotate(45, #{x_size / 2}, #{x_size / 2})"))
            end

            # Add an extra one at top-right and bottom-right, for tiling.
            if x == 0 && y == 0
              svg.group(x_shape, styles.merge(
                                   'transform' => "translate(#{6 * x_size / 2 - x_size / 2},#{dy - 6 * x_size / 2}) rotate(45, #{x_size / 2}, #{x_size / 2})"))
            end
            i += 1
          end
        end

        svg
      end
    end
  end
end
