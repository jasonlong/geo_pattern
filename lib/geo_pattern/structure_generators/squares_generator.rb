module GeoPattern
  module StructureGenerators
    class SquaresGenerator < BaseGenerator
      def generate
        square_size = map(hex_val(0, 1), 0, 15, 10, 60)

        svg.set_width(square_size * 6)
        svg.set_height(square_size * 6)

        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            svg.rect(x*square_size, y*square_size, square_size, square_size, {
              "fill"           => fill,
              "fill-opacity"   => opacity,
              "stroke"         => stroke_color,
              "stroke-opacity" => stroke_opacity
            })
            i += 1
          end
        end

        svg
      end
    end
  end
end
