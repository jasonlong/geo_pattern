module GeoPattern
  module StructureGenerators
    class OctagonsGenerator < BaseGenerator
      private

      def generate_structure
        square_size = map(hex_val(0, 1), 0, 15, 10, 60)
        tile        = build_octogon_shape(square_size)

        svg.set_width(square_size * 6)
        svg.set_height(square_size * 6)

        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            svg.polyline(tile,
                         'fill'           => fill,
                         'fill-opacity'   => opacity,
                         'stroke'         => stroke_color,
                         'stroke-opacity' => stroke_opacity,
                         'transform'      => "translate(#{x * square_size}, #{y * square_size})"
            )
            i += 1
          end
        end

        svg
      end

      def build_octogon_shape(square_size)
        s = square_size
        c = s * 0.33
        "#{c},0,#{s - c},0,#{s},#{c},#{s},#{s - c},#{s - c},#{s},#{c},#{s},0,#{s - c},0,#{c},#{c},0"
      end
    end
  end
end
