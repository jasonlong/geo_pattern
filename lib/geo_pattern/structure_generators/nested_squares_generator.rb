module GeoPattern
  module StructureGenerators
    class NestedSquaresGenerator < BaseGenerator
      private

      def generate_structure
        block_size = map(hex_val(0, 1), 0, 15, 4, 12)
        square_size = block_size * 7

        svg.set_width((square_size + block_size) * 6 + block_size * 6)
        svg.set_height((square_size + block_size) * 6 + block_size * 6)

        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            styles = {
              'fill'   => 'none',
              'stroke' => fill,
              'style'  => {
                'opacity' => opacity,
                'stroke-width' => "#{block_size}px"
              }
            }

            svg.rect(x * square_size + x * block_size * 2 + block_size / 2,
                     y * square_size + y * block_size * 2 + block_size / 2,
                     square_size, square_size, styles)

            val     = hex_val(39 - i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            styles = {
              'fill'   => 'none',
              'stroke' => fill,
              'style'  => {
                'opacity' => opacity,
                'stroke-width' => "#{block_size}px"
              }
            }

            svg.rect(x * square_size + x * block_size * 2 + block_size / 2 + block_size * 2,
                     y * square_size + y * block_size * 2 + block_size / 2 + block_size * 2,
                     block_size * 3, block_size * 3, styles)
            i += 1
          end
        end

        svg
      end
    end
  end
end
