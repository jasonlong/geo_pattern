module GeoPattern
  module StructureGenerators
    class ChevronsGenerator < BaseGenerator
      private

      attr_reader :chevron_height, :chevron_width, :chevron

      def after_initialize
        @chevron_width  = map(hex_val(0, 1), 0, 15, 30, 80)
        @chevron_height = map(hex_val(0, 1), 0, 15, 30, 80)
        @chevron        = build_chevron_shape(chevron_width, chevron_height)

        self.height = chevron_height * 6 * 0.66
        self.width  = chevron_width * 6
      end

      def generate_structure
        i = 0
        for y in 0..5
          for x in 0..5
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

            svg.group(chevron, styles.merge('transform' => "translate(#{x * chevron_width},#{y * chevron_height * 0.66 - chevron_height / 2})"))

            # Add an extra row at the end that matches the first row, for tiling.
            if y == 0
              svg.group(chevron, styles.merge('transform' => "translate(#{x * chevron_width},#{6 * chevron_height * 0.66 - chevron_height / 2})"))
            end
            i += 1
          end
        end

        svg
      end

      def build_chevron_shape(width, height)
        e = height * 0.66
        [
          %{polyline("0,0,#{width / 2},#{height - e},#{width / 2},#{height},0,#{e},0,0")},
          %{polyline("#{width / 2},#{height - e},#{width},0,#{width},#{e},#{width / 2},#{height},#{width / 2},#{height - e}")}
        ]
      end
    end
  end
end
