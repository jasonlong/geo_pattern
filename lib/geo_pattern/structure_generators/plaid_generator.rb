module GeoPattern
  module StructureGenerators
    class PlaidGenerator < BaseGenerator
      private

      def generate_structure
        local_height = 0
        local_width  = 0

        # horizontal stripes
        i = 0
        18.times do
          space = hex_val(i, 1)
          local_height += space + 5

          val           = hex_val(i + 1, 1)
          opacity       = opacity(val)
          fill          = fill_color(val)
          stripe_height = val + 5

          svg.rect(0, local_height, '100%', stripe_height,
                   'opacity'   => opacity,
                   'fill'      => fill
                  )
          local_height += stripe_height
          i += 2
        end

        # vertical stripes
        i = 0
        18.times do
          space = hex_val(i, 1)
          local_width += space + 5

          val          = hex_val(i + 1, 1)
          opacity      = opacity(val)
          fill         = fill_color(val)
          stripe_width = val + 5

          svg.rect(local_width, 0, stripe_width, '100%',
                   'opacity'   => opacity,
                   'fill'      => fill
                  )
          local_width += stripe_width
          i += 2
        end

        self.height = local_height
        self.width  = local_width

        svg
      end
    end
  end
end
