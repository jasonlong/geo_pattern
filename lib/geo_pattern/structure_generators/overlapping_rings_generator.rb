module GeoPattern
  module StructureGenerators
    class OverlappingRingsGenerator < BaseGenerator
      private

      attr_reader :scale, :ring_size, :stroke_width

      def after_initialize
        @scale        = hex_val(0, 1)
        @ring_size    = map(scale, 0, 15, 10, 60)
        @stroke_width = ring_size / 4

        self.height = self.width = ring_size * 6
      end

      def generate_structure
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
                'stroke-width' => "#{stroke_width}px"
              }
            }

            svg.circle(x * ring_size, y * ring_size, ring_size - stroke_width / 2, styles)

            # Add an extra one at top-right, for tiling.
            if x == 0
              svg.circle(6 * ring_size, y * ring_size, ring_size - stroke_width / 2, styles)
            end

            if y == 0
              svg.circle(x * ring_size, 6 * ring_size, ring_size - stroke_width / 2, styles)
            end

            if x == 0 && y == 0
              svg.circle(6 * ring_size, 6 * ring_size, ring_size - stroke_width / 2, styles)
            end
            i += 1
          end
        end

        svg
      end
    end
  end
end
