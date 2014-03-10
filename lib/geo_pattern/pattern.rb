require 'base64'
require 'digest/sha1'
require 'color'

module GeoPattern
  class Pattern
    DEFAULTS = {
      :base_color => '#933c3c'
    }

    PATTERNS = %w[
      octogons
      overlapping_circles
      plus_signs
      xes
      sine_waves
      hexagons
      overlapping_rings
      plaid
      triangles
      squares
      concentric_circles
      diamonds
      tessellation
      nested_squares
      mosaic_squares
      chevrons
    ].freeze

    FILL_COLOR_DARK  = "#222"
    FILL_COLOR_LIGHT = "#ddd"
    STROKE_COLOR     = "#000"
    STROKE_OPACITY   = 0.02
    OPACITY_MIN      = 0.02
    OPACITY_MAX      = 0.15

    attr_reader :opts, :hash, :svg

    def initialize(string, opts={})
      @opts = DEFAULTS.merge(opts)
      @hash = Digest::SHA1.hexdigest string
      @svg  = SVG.new
      generate_background
      generate_pattern
    end

    def svg_string
      svg.to_s
    end

    def to_s
      svg_string
    end

    def base64_string
      Base64.strict_encode64(svg.to_s)
    end

    def uri_image
      "url(data:image/svg+xml;base64,#{base64_string});"
    end

    def generate_background
      if opts[:color]
        rgb = Color::RGB.from_html(opts[:color])
      else
        hue_offset     = map(hex_val(14, 3), 0, 4095, 0, 359)
        sat_offset     = hex_val(17, 1)
        base_color     = Color::RGB.from_html(opts[:base_color]).to_hsl
        base_color.hue = base_color.hue - hue_offset;

        if (sat_offset % 2 == 0)
          base_color.saturation = base_color.saturation + sat_offset
        else
          base_color.saturation = base_color.saturation - sat_offset
        end
        rgb = base_color.to_rgb
      end
      r = (rgb.r * 255).round
      g = (rgb.g * 255).round
      b = (rgb.b * 255).round
      svg.rect(0, 0, "100%", "100%", {"fill" => "rgb(#{r}, #{g}, #{b})"})
    end

    def generate_pattern
      if opts[:generator]
        if PATTERNS.include?(opts[:generator])
          send("geo_#{opts[:generator]}")
        else
          abort("Error: the requested generator is invalid.")
        end
      else
        pattern = hex_val(20, 1)
        send("geo_#{PATTERNS[pattern]}")
      end
    end

    def geo_hexagons
      scale       = hex_val(0, 1)
      side_length = map(scale, 0, 15, 8, 60)
      hex_height  = side_length * Math.sqrt(3)
      hex_width   = side_length * 2
      hex         = build_hexagon_shape(side_length)

      svg.set_width((hex_width * 3) + (side_length * 3))
      svg.set_height(hex_height * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          dy      = x % 2 == 0 ? y*hex_height : y*hex_height + hex_height/2
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"           => fill,
            "fill-opacity"   => opacity,
            "stroke"         => STROKE_COLOR,
            "stroke-opacity" => STROKE_OPACITY
          }

          svg.polyline(hex, styles.merge({"transform" => "translate(#{x*side_length*1.5 - hex_width/2}, #{dy - hex_height/2})"}))

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            svg.polyline(hex, styles.merge({"transform" => "translate(#{6*side_length*1.5 - hex_width/2}, #{dy - hex_height/2})"}))
          end

          # Add an extra row at the end that matches the first row, for tiling.
          if (y == 0)
            dy = x % 2 == 0 ? 6*hex_height : 6*hex_height + hex_height/2;
            svg.polyline(hex, styles.merge({"transform" => "translate(#{x*side_length*1.5 - hex_width/2}, #{dy - hex_height/2})"}))
          end

           # Add an extra one at bottom-right, for tiling.
          if (x == 0 && y == 0)
            svg.polyline(hex, styles.merge({"transform" => "translate(#{6*side_length*1.5 - hex_width/2}, #{5*hex_height + hex_height/2})"}))
          end
          i += 1
        end
      end
    end

    def geo_sine_waves
      period     = map(hex_val(0, 1), 0, 15, 100, 400).floor
      amplitude  = map(hex_val(1, 1), 0, 15, 30, 100).floor
      wave_width = map(hex_val(2, 1), 0, 15, 3, 30).floor

      svg.set_width(period)
      svg.set_height(wave_width * 36)

      for i in 0..35
        val      = hex_val(i, 1)
        opacity  = opacity(val)
        fill     = fill_color(val)
        x_offset = period / 4 * 0.7

        styles = {
            "fill"      => "none",
            "stroke"    => fill,
            "style"     => {
              "opacity"      => opacity,
              "stroke-width" => "#{wave_width}px"
            }
        }

        str = "M0 "+amplitude.to_s+
              " C "+x_offset.to_s+" 0, "+(period/2 - x_offset).to_s+" 0, "+(period/2).to_s+" "+amplitude.to_s+
              " S "+(period-x_offset).to_s+" "+(amplitude*2).to_s+", "+period.to_s+" "+amplitude.to_s+
              " S "+(period*1.5-x_offset).to_s+" 0, "+(period*1.5).to_s+", "+amplitude.to_s;

        svg.path(str, styles.merge({"transform" => "translate(-#{period/4}, #{wave_width*i-amplitude*1.5})"}))
        svg.path(str, styles.merge({"transform" => "translate(-#{period/4}, #{wave_width*i-amplitude*1.5 + wave_width*36})"}))
      end
    end

    def geo_chevrons
      chevron_width  = map(hex_val(0, 1), 0, 15, 30, 80)
      chevron_height = map(hex_val(0, 1), 0, 15, 30, 80)
      chevron        = build_chevron_shape(chevron_width, chevron_height)

      svg.set_width(chevron_width * 6)
      svg.set_height(chevron_height * 6 * 0.66)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles  = {
                "stroke"         => STROKE_COLOR,
                "stroke-opacity" => STROKE_OPACITY,
                "fill"           => fill,
                "fill-opacity"   => opacity,
                "stroke-width"   => 1
          }

          svg.group(chevron, styles.merge({"transform" => "translate(#{x*chevron_width},#{y*chevron_height*0.66 - chevron_height/2})"}))

          # Add an extra row at the end that matches the first row, for tiling.
          if (y == 0)
            svg.group(chevron, styles.merge({"transform" => "translate(#{x*chevron_width},#{6*chevron_height*0.66 - chevron_height/2})"}))
          end
          i += 1
        end
      end
    end

    def geo_plus_signs
      square_size = map(hex_val(0, 1), 0, 15, 10, 25)
      plus_size   = square_size * 3
      plus_shape  = build_plus_shape(square_size)

      svg.set_width(square_size * 12)
      svg.set_height(square_size * 12)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)
          dx      = (y % 2 == 0) ? 0 : 1

          styles = {
            "fill"           => fill,
            "stroke"         => STROKE_COLOR,
            "stroke-opacity" => STROKE_OPACITY,
            "style"          => {
              "fill-opacity" => opacity
            }
          }

          svg.group(plus_shape, styles.merge({
            "transform" => "translate(#{x*plus_size - x*square_size + dx*square_size - square_size},#{y*plus_size - y*square_size - plus_size/2})"}))

          # Add an extra column on the right for tiling.
          if (x == 0)
            svg.group(plus_shape, styles.merge({
              "transform" => "translate(#{4*plus_size - x*square_size + dx*square_size - square_size},#{y*plus_size - y*square_size - plus_size/2})"}))
          end

          # Add an extra row on the bottom that matches the first row, for tiling.
          if (y == 0)
            svg.group(plus_shape, styles.merge({
              "transform" => "translate(#{x*plus_size - x*square_size + dx*square_size - square_size},#{4*plus_size - y*square_size - plus_size/2})"}))
          end

          # Add an extra one at top-right and bottom-right, for tiling.
          if (x == 0 && y == 0)
            svg.group(plus_shape, styles.merge({
              "transform" => "translate(#{4*plus_size - x*square_size + dx*square_size - square_size},#{4*plus_size - y*square_size - plus_size/2})"}))
          end
          i += 1
        end
      end
    end

    def geo_xes
      square_size = map(hex_val(0, 1), 0, 15, 10, 25)
      x_shape     = build_plus_shape(square_size) # rotated later
      x_size      = square_size * 3 * 0.943

      svg.set_width(x_size * 3)
      svg.set_height(x_size * 3)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          dy      = x % 2 == 0 ? y*x_size - x_size*0.5 : y*x_size - x_size*0.5 + x_size/4
          fill    = fill_color(val)

          styles = {
            "fill"  => fill,
            "style" => {
              "opacity" => opacity
            }
          }

          svg.group(x_shape, styles.merge({
            "transform" => "translate(#{x*x_size/2 - x_size/2},#{dy - y*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})"}))

          # Add an extra column on the right for tiling.
          if (x == 0)
            svg.group(x_shape, styles.merge({
              "transform" => "translate(#{6*x_size/2 - x_size/2},#{dy - y*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})"}))
          end

          # Add an extra row on the bottom that matches the first row, for tiling.
          if (y == 0)
            dy = x % 2 == 0 ? 6*x_size - x_size/2 : 6*x_size - x_size/2 + x_size/4;
            svg.group(x_shape, styles.merge({
              "transform" => "translate(#{x*x_size/2 - x_size/2},#{dy - 6*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})"}))
          end

          # These can hang off the bottom, so put a row at the top for tiling.
          if (y == 5)
            svg.group(x_shape, styles.merge({
              "transform" => "translate(#{x*x_size/2 - x_size/2},#{dy - 11*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})"}))
          end

          # Add an extra one at top-right and bottom-right, for tiling.
          if (x == 0 && y == 0)
            svg.group(x_shape, styles.merge({
              "transform" => "translate(#{6*x_size/2 - x_size/2},#{dy - 6*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})"}))
          end
          i += 1
        end
      end
    end

    def geo_overlapping_circles
      scale    = hex_val(0, 1)
      diameter = map(scale, 0, 15, 25, 200)
      radius   = diameter/2;

      svg.set_width(radius * 6)
      svg.set_height(radius * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"  => fill,
            "style" => {
              "opacity" => opacity
            }
          }

          svg.circle(x*radius, y*radius, radius, styles)

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            svg.circle(6*radius, y*radius, radius, styles)
          end

          # Add an extra row at the end that matches the first row, for tiling.
          if (y == 0)
            svg.circle(x*radius, 6*radius, radius, styles)
          end

          # Add an extra one at bottom-right, for tiling.
          if (x == 0 and y == 0)
            svg.circle(6*radius, 6*radius, radius, styles)
          end
          i += 1
        end
      end
    end

    def geo_octogons
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

          svg.polyline(tile, {
            "fill"           => fill,
            "fill-opacity"   => opacity,
            "stroke"         => STROKE_COLOR,
            "stroke-opacity" => STROKE_OPACITY,
            "transform"      => "translate(#{x*square_size}, #{y*square_size})"
          })
          i += 1
        end
      end
    end

    def geo_squares
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
            "stroke"         => STROKE_COLOR,
            "stroke-opacity" => STROKE_OPACITY
          })
          i += 1
        end
      end
    end

    def geo_concentric_circles
      scale        = hex_val(0, 1)
      ring_size    = map(scale, 0, 15, 10, 60)
      stroke_width = ring_size / 5

      svg.set_width((ring_size + stroke_width) * 6)
      svg.set_height((ring_size + stroke_width) * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          svg.circle(
                  x*ring_size + x*stroke_width + (ring_size + stroke_width)/2,
                  y*ring_size + y*stroke_width + (ring_size + stroke_width)/2,
                  ring_size/2, {
                    "fill"   => "none",
                    "stroke" => fill,
                    "style"  => {
                      "opacity" => opacity,
                      "stroke-width" => "#{stroke_width}px"
                    }
                  })

          val     = hex_val(39-i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          svg.circle(
                  x*ring_size + x*stroke_width + (ring_size + stroke_width)/2,
                  y*ring_size + y*stroke_width + (ring_size + stroke_width)/2,
                  ring_size/4, {
                    "fill"         => fill,
                    "fill-opacity" => opacity
                  })

          i += 1
        end
      end
    end

    def geo_overlapping_rings
      scale        = hex_val(0, 1)
      ring_size    = map(scale, 0, 15, 10, 60)
      stroke_width = ring_size / 4

      svg.set_width(ring_size * 6)
      svg.set_height(ring_size * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"   => "none",
            "stroke" => fill,
            "style"  => {
              "opacity" => opacity,
              "stroke-width" => "#{stroke_width}px"
            }
          }

          svg.circle(x*ring_size, y*ring_size, ring_size - stroke_width/2, styles)

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            svg.circle(6*ring_size, y*ring_size, ring_size - stroke_width/2, styles)
          end

          if (y == 0)
            svg.circle(x*ring_size, 6*ring_size, ring_size - stroke_width/2, styles)
          end

          if (x == 0 and y == 0)
            svg.circle(6*ring_size, 6*ring_size, ring_size - stroke_width/2, styles)
          end
          i += 1
        end
      end
    end

    def geo_triangles
      scale           = hex_val(0, 1)
      side_length     = map(scale, 0, 15, 15, 80)
      triangle_height = side_length/2 * Math.sqrt(3)
      triangle        = build_triangle_shape(side_length, triangle_height)

      svg.set_width(side_length * 3)
      svg.set_height(triangle_height * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"           => fill,
            "fill-opacity"   => opacity,
            "stroke"         => STROKE_COLOR,
            "stroke-opacity" => STROKE_OPACITY
          }

          rotation = ""
          if y % 2 == 0
            rotation = x % 2 == 0 ? 180 : 0
          else
            rotation = x % 2 != 0 ? 180 : 0
          end

          svg.polyline(triangle, styles.merge({
            "transform" => "translate(#{x*side_length*0.5 - side_length/2}, #{triangle_height*y}) rotate(#{rotation}, #{side_length/2}, #{triangle_height/2})"}))

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            svg.polyline(triangle, styles.merge({
              "transform" => "translate(#{6*side_length*0.5 - side_length/2}, #{triangle_height*y}) rotate(#{rotation}, #{side_length/2}, #{triangle_height/2})"}))
          end
          i += 1
        end
      end
    end

    def geo_diamonds
      diamond_width  = map(hex_val(0, 1), 0, 15, 10, 50)
      diamond_height = map(hex_val(1, 1), 0, 15, 10, 50)
      diamond        = build_diamond_shape(diamond_width, diamond_height)

      svg.set_width(diamond_width * 6)
      svg.set_height(diamond_height * 3)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"           => fill,
            "fill-opacity"   => opacity,
            "stroke"         => STROKE_COLOR,
            "stroke-opacity" => STROKE_OPACITY
          }

          dx = (y % 2 == 0) ? 0 : diamond_width / 2

          svg.polyline(diamond, styles.merge({
            "transform" => "translate(#{x*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*y - diamond_height/2})"}))

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            svg.polyline(diamond, styles.merge({
              "transform" => "translate(#{6*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*y - diamond_height/2})"}))
          end

          # Add an extra row at the end that matches the first row, for tiling.
          if (y == 0)
            svg.polyline(diamond, styles.merge({
              "transform" => "translate(#{x*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*6 - diamond_height/2})"}))
          end

          # Add an extra one at bottom-right, for tiling.
          if (x == 0 and y == 0)
            svg.polyline(diamond, styles.merge({
              "transform" => "translate(#{6*diamond_width - diamond_width/2 + dx}, #{diamond_height/2*6 - diamond_height/2})"}))
          end
          i += 1
        end
      end
    end

    def geo_nested_squares
      block_size = map(hex_val(0, 1), 0, 15, 4, 12)
      square_size = block_size * 7

      svg.set_width((square_size + block_size)*6 + block_size*6)
      svg.set_height((square_size + block_size)*6 + block_size*6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = hex_val(i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"   => "none",
            "stroke" => fill,
            "style"  => {
              "opacity" => opacity,
              "stroke-width" => "#{block_size}px"
            }
          }

          svg.rect(x*square_size + x*block_size*2 + block_size/2,
                    y*square_size + y*block_size*2 + block_size/2,
                    square_size, square_size, styles)

          val     = hex_val(39-i, 1)
          opacity = opacity(val)
          fill    = fill_color(val)

          styles = {
            "fill"   => "none",
            "stroke" => fill,
            "style"  => {
              "opacity" => opacity,
              "stroke-width" => "#{block_size}px"
            }
          }

          svg.rect(x*square_size + x*block_size*2 + block_size/2 + block_size*2,
                    y*square_size + y*block_size*2 + block_size/2 + block_size*2,
                    block_size * 3, block_size * 3, styles)
          i += 1
        end
      end
    end

    def geo_mosaic_squares
      triangle_size = map(hex_val(0, 1), 0, 15, 15, 50)

      svg.set_width(triangle_size * 8)
      svg.set_height(triangle_size * 8)

      i = 0
      for y in 0..3
        for x in 0..3

          if (x % 2 == 0)
            if (y % 2 == 0)
              draw_outer_mosaic_tile(x*triangle_size*2, y*triangle_size*2, triangle_size, hex_val(i, 1))
            else
              draw_inner_mosaic_tile(x*triangle_size*2, y*triangle_size*2, triangle_size, [hex_val(i, 1), hex_val(i+1, 1)])
            end
          else
            if (y % 2 == 0)
              draw_inner_mosaic_tile(x*triangle_size*2, y*triangle_size*2, triangle_size, [hex_val(i, 1), hex_val(i+1, 1)])
            else
              draw_outer_mosaic_tile(x*triangle_size*2, y*triangle_size*2, triangle_size, hex_val(i, 1))
            end
          end
          i += 1
        end
      end
    end

    def geo_plaid
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

    def geo_tessellation
      # 3.4.6.4 semi-regular tessellation
      side_length     = map(hex_val(0, 1), 0, 15, 5, 40)
      hex_height      = side_length * Math.sqrt(3)
      hex_width       = side_length * 2
      triangle_height = side_length/2 * Math.sqrt(3)
      triangle        = build_rotated_triangle_shape(side_length, triangle_height)
      tile_width      = side_length*3 + triangle_height*2
      tile_height     = (hex_height * 2) + (side_length * 2)

      svg.set_width(tile_width)
      svg.set_height(tile_height)

      for i in 0..19
        val     = hex_val(i, 1)
        opacity = opacity(val)
        fill    = fill_color(val)

        styles  = {
                "stroke"         => STROKE_COLOR,
                "stroke-opacity" => STROKE_OPACITY,
                "fill"           => fill,
                "fill-opacity"   => opacity,
                "stroke-width"   => 1
        }

        case i
        when 0 # all 4 corners
          svg.rect(-side_length/2, -side_length/2, side_length, side_length, styles)
          svg.rect(tile_width - side_length/2, -side_length/2, side_length, side_length, styles)
          svg.rect(-side_length/2, tile_height-side_length/2, side_length, side_length, styles)
          svg.rect(tile_width - side_length/2, tile_height-side_length/2, side_length, side_length, styles)
        when 1 # center / top square
          svg.rect(hex_width/2 + triangle_height, hex_height/2, side_length, side_length, styles)
        when 2 # side squares
          svg.rect(-side_length/2, tile_height/2-side_length/2, side_length, side_length, styles)
          svg.rect(tile_width-side_length/2, tile_height/2-side_length/2, side_length, side_length, styles)
        when 3 # center / bottom square
          svg.rect(hex_width/2 + triangle_height, hex_height * 1.5 + side_length, side_length, side_length, styles)
        when 4 # left top / bottom triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{side_length/2}, #{-side_length/2}) rotate(0, #{side_length/2}, #{triangle_height/2})"}))
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{side_length/2}, #{tile_height--side_length/2}) rotate(0, #{side_length/2}, #{triangle_height/2}) scale(1, -1)"}))
        when 5 # right top / bottom triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{tile_width-side_length/2}, #{-side_length/2}) rotate(0, #{side_length/2}, #{triangle_height/2}) scale(-1, 1)"}))
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{tile_width-side_length/2}, #{tile_height+side_length/2}) rotate(0, #{side_length/2}, #{triangle_height/2}) scale(-1, -1)"}))
        when 6 # center / top / right triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{tile_width/2+side_length/2}, #{hex_height/2})"}))
        when 7 # center / top / left triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{tile_width-tile_width/2-side_length/2}, #{hex_height/2}) scale(-1, 1)"}))
        when 8 # center / bottom / right triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{tile_width/2+side_length/2}, #{tile_height-hex_height/2}) scale(1, -1)"}))
        when 9 # center / bottom / left triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{tile_width-tile_width/2-side_length/2}, #{tile_height-hex_height/2}) scale(-1, -1)"}))
        when 10 # left / middle triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{side_length/2}, #{tile_height/2 - side_length/2})"}))
        when 11 # right / middle triangle
          svg.polyline(triangle, styles.merge({"transform" => "translate(#{tile_width-side_length/2}, #{tile_height/2 - side_length/2}) scale(-1, 1)"}))
        when 12 # left / top square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "translate(#{side_length/2}, #{side_length/2}) rotate(-30, 0, 0)"}))
        when 13 # right / top square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "scale(-1, 1) translate(#{-tile_width+side_length/2}, #{side_length/2}) rotate(-30, 0, 0)" }))
        when 14 # left / center-top square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "translate(#{side_length/2}, #{tile_height/2-side_length/2-side_length}) rotate(30, 0, #{side_length})" }))
        when 15 # right / center-top square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "scale(-1, 1) translate(#{-tile_width+side_length/2}, #{tile_height/2-side_length/2-side_length}) rotate(30, 0, #{side_length})" }))
        when 16 # left / center-top square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "scale(1, -1) translate(#{side_length/2}, #{-tile_height+tile_height/2-side_length/2-side_length}) rotate(30, 0, #{side_length})" }))
        when 17 # right / center-bottom square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "scale(-1, -1) translate(#{-tile_width+side_length/2}, #{-tile_height+tile_height/2-side_length/2-side_length}) rotate(30, 0, #{side_length})" }))
        when 18 # left / bottom square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "scale(1, -1) translate(#{side_length/2}, #{-tile_height+side_length/2}) rotate(-30, 0, 0)"}))
        when 19 # right / bottom square
          svg.rect(0, 0, side_length, side_length,
                    styles.merge({"transform" => "scale(-1, -1) translate(#{-tile_width+side_length/2}, #{-tile_height+side_length/2}) rotate(-30, 0, 0)"}))
        end
      end
    end

    def build_chevron_shape(width, height)
      e = height * 0.66
      [
        %Q{polyline("0,0,#{width/2},#{height-e},#{width/2},#{height},0,#{e},0,0")},
        %Q{polyline("#{width/2},#{height-e},#{width},0,#{width},#{e},#{width/2},#{height},#{width/2},#{height-e}")}
      ]
    end

    def build_octogon_shape(square_size)
      s = square_size
      c = s * 0.33
      "#{c},0,#{s-c},0,#{s},#{c},#{s},#{s-c},#{s-c},#{s},#{c},#{s},0,#{s-c},0,#{c},#{c},0"
    end

    def build_hexagon_shape(sideLength)
      c = sideLength
      a = c/2
      b = Math.sin(60 * Math::PI / 180)*c
      "0,#{b},#{a},0,#{a+c},0,#{2*c},#{b},#{a+c},#{2*b},#{a},#{2*b},0,#{b}"
    end

    def build_plus_shape(square_size)
      [
        "rect(#{square_size},0,#{square_size},#{square_size * 3})",
        "rect(0, #{square_size},#{square_size * 3},#{square_size})"
      ]
    end

    def build_triangle_shape(side_length, height)
      half_width = side_length / 2
      "#{half_width}, 0, #{side_length}, #{height}, 0, #{height}, #{half_width}, 0"
    end

    def build_rotated_triangle_shape(side_length, width)
      half_height = side_length / 2
      "0, 0, #{width}, #{half_height}, 0, #{side_length}, 0, 0"
    end

    def build_right_triangle_shape(side_length)
      "0, 0, #{side_length}, #{side_length}, 0, #{side_length}, 0, 0"
    end

    def build_diamond_shape(width, height)
      "#{width/2}, 0, #{width}, #{height/2}, #{width/2}, #{height}, 0, #{height/2}"
    end

    def draw_inner_mosaic_tile(x, y, triangle_size, vals)
      triangle = build_right_triangle_shape(triangle_size)
      opacity  = opacity(vals[0])
      fill     = fill_color(vals[0])
      styles   = {
        "stroke"         => STROKE_COLOR,
        "stroke-opacity" => STROKE_OPACITY,
        "fill-opacity"   => opacity,
        "fill"           => fill
      }
      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x+triangle_size}, #{y}) scale(-1, 1)"}))
      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x+triangle_size}, #{y+triangle_size*2}) scale(1, -1)"}))

      opacity = opacity(vals[1])
      fill    = fill_color(vals[1])
      styles  = {
        "stroke"         => STROKE_COLOR,
        "stroke-opacity" => STROKE_OPACITY,
        "fill-opacity"   => opacity,
        "fill"           => fill
      }
      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x+triangle_size}, #{y+triangle_size*2}) scale(-1, -1)"}))
      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x+triangle_size}, #{y}) scale(1, 1)"}))
    end

    def draw_outer_mosaic_tile(x, y, triangle_size, val)
      opacity  = opacity(val)
      fill     = fill_color(val)
      triangle = build_right_triangle_shape(triangle_size)
      styles   = {
        "stroke"         => STROKE_COLOR,
        "stroke-opacity" => STROKE_OPACITY,
        "fill-opacity"   => opacity,
        "fill"           => fill
      }

      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x}, #{y+triangle_size}) scale(1, -1)"}))
      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x+triangle_size*2}, #{y+triangle_size}) scale(-1, -1)"}))
      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x}, #{y+triangle_size}) scale(1, 1)"}))
      svg.polyline(triangle, styles.merge({"transform" => "translate(#{x+triangle_size*2}, #{y+triangle_size}) scale(-1, 1)"}))
    end

    def hex_val(index, len)
      hash[index, len || 1].to_i(16)
    end

    def fill_color(val)
      (val % 2 == 0) ? FILL_COLOR_LIGHT : FILL_COLOR_DARK
    end

    def opacity(val)
      map(val, 0, 15, OPACITY_MIN, OPACITY_MAX)
    end

    # Ruby implementation of Processing's map function
    # http://processing.org/reference/map_.html
    def map(value, v_min, v_max, d_min, d_max) # v for value, d for desired
      v_value = value.to_f # so it returns float

      v_range = v_max - v_min
      d_range = d_max - d_min
      (v_value - v_min) * d_range / v_range + d_min
    end
  end
end
