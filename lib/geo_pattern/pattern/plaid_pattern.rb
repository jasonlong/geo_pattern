module GeoPattern
  class PlaidPattern < BasePattern
    def render_to_svg
      height = 0
      width  = 0

      # horizontal stripes
      i = 0
      18.times do
        space   = hex_val(i, 1)
        height += space + 5

        val           = hex_val(i+1, 1)
        opacity       = opacity(val)
        fill          = fill_color(val)
        stripe_height = val + 5

        svg.rect(0, height, "100%", stripe_height, {
              "opacity"   => opacity,
              "fill"      => fill
        })
        height += stripe_height
        i += 2
      end

      # vertical stripes
      i = 0
      18.times do
        space  = hex_val(i, 1)
        width += space + 5

        val          = hex_val(i+1, 1)
        opacity      = opacity(val)
        fill         = fill_color(val)
        stripe_width = val + 5

        svg.rect(width, 0, stripe_width, "100%", {
              "opacity"   => opacity,
              "fill"      => fill
        })
        width += stripe_width
        i += 2
      end

      svg.set_width(width)
      svg.set_height(height)
    end
  end
end
