module GeoPattern
  module StructureGenerators
    class TessellationGenerator < BaseGenerator
      private

      attr_reader :side_length, :hex_height, :hex_width, :triangle_height, :triangle, :tile_width, :tile_height

      def after_initialize
        # 3.4.6.4 semi-regular tessellation
        @side_length     = map(hex_val(0, 1), 0, 15, 5, 40)
        @hex_height      = side_length * Math.sqrt(3)
        @hex_width       = side_length * 2
        @triangle_height = side_length / 2 * Math.sqrt(3)
        @triangle        = build_rotated_triangle_shape(side_length, triangle_height)
        @tile_width      = side_length * 3 + triangle_height * 2
        @tile_height     = (hex_height * 2) + (side_length * 2)

        self.height = tile_height
        self.width  = tile_width
      end

      def generate_structure
        for i in 0..19
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles  = {
            'stroke'         => stroke_color,
            'stroke-opacity' => stroke_opacity,
            'fill'           => fill,
            'fill-opacity'   => opacity,
            'stroke-width'   => 1
          }

          case i
          when 0 # all 4 corners
            svg.rect(-side_length / 2, -side_length / 2, side_length, side_length, styles)
            svg.rect(tile_width - side_length / 2, -side_length / 2, side_length, side_length, styles)
            svg.rect(-side_length / 2, tile_height - side_length / 2, side_length, side_length, styles)
            svg.rect(tile_width - side_length / 2, tile_height - side_length / 2, side_length, side_length, styles)
          when 1 # center / top square
            svg.rect(hex_width / 2 + triangle_height, hex_height / 2, side_length, side_length, styles)
          when 2 # side squares
            svg.rect(-side_length / 2, tile_height / 2 - side_length / 2, side_length, side_length, styles)
            svg.rect(tile_width - side_length / 2, tile_height / 2 - side_length / 2, side_length, side_length, styles)
          when 3 # center / bottom square
            svg.rect(hex_width / 2 + triangle_height, hex_height * 1.5 + side_length, side_length, side_length, styles)
          when 4 # left top / bottom triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{side_length / 2}, #{-side_length / 2}) rotate(0, #{side_length / 2}, #{triangle_height / 2})"))
            svg.polyline(triangle, styles.merge('transform' => "translate(#{side_length / 2}, #{tile_height - -side_length / 2}) rotate(0, #{side_length / 2}, #{triangle_height / 2}) scale(1, -1)"))
          when 5 # right top / bottom triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{tile_width - side_length / 2}, #{-side_length / 2}) rotate(0, #{side_length / 2}, #{triangle_height / 2}) scale(-1, 1)"))
            svg.polyline(triangle, styles.merge('transform' => "translate(#{tile_width - side_length / 2}, #{tile_height + side_length / 2}) rotate(0, #{side_length / 2}, #{triangle_height / 2}) scale(-1, -1)"))
          when 6 # center / top / right triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{tile_width / 2 + side_length / 2}, #{hex_height / 2})"))
          when 7 # center / top / left triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{tile_width - tile_width / 2 - side_length / 2}, #{hex_height / 2}) scale(-1, 1)"))
          when 8 # center / bottom / right triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{tile_width / 2 + side_length / 2}, #{tile_height - hex_height / 2}) scale(1, -1)"))
          when 9 # center / bottom / left triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{tile_width - tile_width / 2 - side_length / 2}, #{tile_height - hex_height / 2}) scale(-1, -1)"))
          when 10 # left / middle triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{side_length / 2}, #{tile_height / 2 - side_length / 2})"))
          when 11 # right / middle triangle
            svg.polyline(triangle, styles.merge('transform' => "translate(#{tile_width - side_length / 2}, #{tile_height / 2 - side_length / 2}) scale(-1, 1)"))
          when 12 # left / top square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "translate(#{side_length / 2}, #{side_length / 2}) rotate(-30, 0, 0)"))
          when 13 # right / top square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "scale(-1, 1) translate(#{-tile_width + side_length / 2}, #{side_length / 2}) rotate(-30, 0, 0)"))
          when 14 # left / center-top square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "translate(#{side_length / 2}, #{tile_height / 2 - side_length / 2 - side_length}) rotate(30, 0, #{side_length})"))
          when 15 # right / center-top square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "scale(-1, 1) translate(#{-tile_width + side_length / 2}, #{tile_height / 2 - side_length / 2 - side_length}) rotate(30, 0, #{side_length})"))
          when 16 # left / center-top square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "scale(1, -1) translate(#{side_length / 2}, #{-tile_height + tile_height / 2 - side_length / 2 - side_length}) rotate(30, 0, #{side_length})"))
          when 17 # right / center-bottom square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "scale(-1, -1) translate(#{-tile_width + side_length / 2}, #{-tile_height + tile_height / 2 - side_length / 2 - side_length}) rotate(30, 0, #{side_length})"))
          when 18 # left / bottom square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "scale(1, -1) translate(#{side_length / 2}, #{-tile_height + side_length / 2}) rotate(-30, 0, 0)"))
          when 19 # right / bottom square
            svg.rect(0, 0, side_length, side_length,
                     styles.merge('transform' => "scale(-1, -1) translate(#{-tile_width + side_length / 2}, #{-tile_height + side_length / 2}) rotate(-30, 0, 0)"))
          end
        end

        svg
      end

      def build_rotated_triangle_shape(side_length, width)
        half_height = side_length / 2
        "0, 0, #{width}, #{half_height}, 0, #{side_length}, 0, 0"
      end
    end
  end
end
