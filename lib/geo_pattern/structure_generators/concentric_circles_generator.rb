module GeoPattern
  module StructureGenerators
    class ConcentricCirclesGenerator < BaseGenerator
      private

      attr_reader :scale, :ring_size, :stroke_width

      def after_initialize
        @scale        = hex_val(0, 1)
        @ring_size    = map(scale, 0, 15, 10, 60)
        @stroke_width = ring_size / 5

        self.width = self.height = (ring_size + stroke_width) * 6
      end

      def generate_structure
        i = 0
        for y in 0..5
          for x in 0..5
            val     = hex_val(i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            svg.circle(
              x * ring_size + x * stroke_width + (ring_size + stroke_width) / 2,
              y * ring_size + y * stroke_width + (ring_size + stroke_width) / 2,
              ring_size / 2,
              'fill'   => 'none',
              'stroke' => fill,
              'style'  => {
                'opacity' => opacity,
                'stroke-width' => "#{stroke_width}px"
              }
            )

            val     = hex_val(39 - i, 1)
            opacity = opacity(val)
            fill    = fill_color(val)

            svg.circle(
              x * ring_size + x * stroke_width + (ring_size + stroke_width) / 2,
              y * ring_size + y * stroke_width + (ring_size + stroke_width) / 2,
              ring_size / 4,
              'fill'         => fill,
              'fill-opacity' => opacity
            )

            i += 1
          end
        end

        svg
      end
    end
  end
end
