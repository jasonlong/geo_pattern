require 'base64'
require 'digest/sha1'
require 'color'

module GeoPattern
  class Pattern
    def initialize(string)
      @hash = Digest::SHA1.hexdigest string
      @svg  = SVG.new
      generate_background
      generate_pattern
    end

    def svg_string
      @svg.to_s
    end

    def to_s
      svg_string
    end

    def base64_string
      Base64.encode64(@svg.to_s)
    end

    def generate_background
      hue_offset = map(@hash[14, 3].to_i(16), 0, 4095, 0, 359)
      sat_offset = @hash[17, 1].to_i(16)
      base_color = Color::HSL.new(0, 42, 41)
      base_color.hue = base_color.hue - hue_offset;

      if sat_offset % 2
        base_color.saturation = base_color.saturation + sat_offset
      else
        base_color.saturation = base_color.saturation - sat_offset
      end
      rgb = base_color.to_rgb
      r = (rgb.r * 255).round
      g = (rgb.g * 255).round
      b = (rgb.b * 255).round
      @svg.rect(0, 0, "100%", "100%", {"fill" => "rgb(#{r}, #{g}, #{b})"})
    end

    def generate_pattern
      pattern = @hash[20, 1].to_i(16)
      case pattern
      when 0
        geo_triangles
      when 1
        geo_overlapping_circles
      when 2
        geo_hexagons
      when 3
        geo_xes
      when 4
        geo_sine_waves
      when 5
      when 6
      when 7
      when 8
      when 9
        geo_squares
      when 10
        geo_rings
      when 11
      when 12
      when 13
      when 14
      when 15
      end
    end
      
    def geo_hexagons
      scale       = @hash[1, 1].to_i(16)
      side_length = map(scale, 0, 15, 5, 120)
      hex_height  = side_length * Math.sqrt(3)
      hex_width   = side_length * 2
      hex         = build_hexagon_shape(side_length)

      @svg.set_width((hex_width * 3) + (side_length * 3))
      @svg.set_height(hex_height * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = @hash[i, 1].to_i(16)
          dy      = x % 2 == 0 ? y*hex_height : y*hex_height + hex_height/2
          opacity = map(val, 0, 15, 0.02, 0.18)
          fill    = (val % 2 == 0) ? "#ddd" : "#222"
          tmp_hex = String.new(hex)

          @svg.polyline(hex, {
            "opacity"   => opacity,
            "fill"      => fill,
            "stroke"    => "#000000",
            "transform" => "translate(#{x*side_length*1.5 - hex_width/2}, #{dy - hex_height/2})"
          })

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            @svg.polyline(hex, {
              "opacity"   => opacity,
              "fill"      => fill,
              "stroke"    => "#000000",
              "transform" => "translate(#{6*side_length*1.5 - hex_width/2}, #{dy - hex_height/2})"
            })
          end

          # Add an extra row at the end that matches the first row, for tiling.
          if (y == 0)
            dy = x % 2 == 0 ? 6*hex_height : 6*hex_height + hex_height/2;
            @svg.polyline(hex, {
              "opacity"   => opacity,
              "fill"      => fill,
              "stroke"    => "#000000",
              "transform" => "translate(#{x*side_length*1.5 - hex_width/2}, #{dy - hex_height/2})"
            })
          end

           # Add an extra one at bottom-right, for tiling.
          if (x == 0 && y == 0)
            @svg.polyline(hex, {
              "opacity"   => opacity,
              "fill"      => fill,
              "stroke"    => "#000000",
              "transform" => "translate(#{6*side_length*1.5 - hex_width/2}, #{5*hex_height + hex_height/2})"
            })
          end
          i += 1
        end
      end
    end

    def geo_sine_waves
      period     = map(@hash[1, 1].to_i(16), 0, 15, 100, 400).floor
      amplitude  = map(@hash[2, 1].to_i(16), 0, 15, 30, 100).floor
      wave_width = map(@hash[3, 1].to_i(16), 0, 15, 3, 30).floor

      @svg.set_width(period)
      @svg.set_height(wave_width * 36)

      for i in 0..35
        val      = @hash[i, 1].to_i(16)
        fill     = (val % 2 == 0) ? "#ddd" : "#222"
        opacity  = map(val, 0, 15, 0.02, 0.15)
        x_offset = period / 4 * 0.7

        str = "M0 "+amplitude.to_s+
              " C "+x_offset.to_s+" 0, "+(period/2 - x_offset).to_s+" 0, "+(period/2).to_s+" "+amplitude.to_s+
              " S "+(period-x_offset).to_s+" "+(amplitude*2).to_s+", "+period.to_s+" "+amplitude.to_s+
              " S "+(period*1.5-x_offset).to_s+" 0, "+(period*1.5).to_s+", "+amplitude.to_s;

        @svg.path(str, {
                    "fill"      => "none",
                    "stroke"    => fill,
                    "transform" => "translate(-#{period/4}, #{wave_width*i-amplitude*1.5})",
                    "style"     => {
                      "opacity" => opacity,
                      "stroke-width" => "#{wave_width}px"
                    }
                  })

        @svg.path(str, {
                    "fill"      => "none",
                    "stroke"    => fill,
                    "transform" => "translate(-#{period/4}, #{wave_width*i-amplitude*1.5 + wave_width*36})",
                    "style"     => {
                      "opacity" => opacity,
                      "stroke-width" => "#{wave_width}px"
                    }
                  })
      end
    end

    def geo_xes
      square_size = map(@hash[0, 1].to_i(16), 0, 15, 10, 25)
      x_shape     = build_x_shape(square_size)
      x_size      = square_size * 3 * 0.943

      @svg.set_width(x_size * 3)
      @svg.set_height(x_size * 3)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = @hash[i, 1].to_i(16)
          opacity = map(val, 0, 15, 0.02, 0.15)
          dy      = x % 2 == 0 ? y*x_size - x_size*0.5 : y*x_size - x_size*0.5 + x_size/4
          fill    = (val % 2 == 0) ? "#ddd" : "#222"

          @svg.group(x_shape, {
            "fill"  => fill,
            "transform" => "translate(#{x*x_size/2 - x_size/2},#{dy - y*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})",
            "style" => {
              "opacity" => opacity
            }
          })

          # Add an extra column on the right for tiling.
          if (x == 0)
            @svg.group(x_shape, {
              "fill"  => fill,
              "transform" => "translate(#{6*x_size/2 - x_size/2},#{dy - y*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})",
              "style" => {
                "opacity" => opacity
              }
            })
          end 

          # Add an extra row on the bottom that matches the first row, for tiling.
          if (y == 0)
            dy = x % 2 == 0 ? 6*x_size - x_size/2 : 6*x_size - x_size/2 + x_size/4;
            @svg.group(x_shape, {
              "fill"  => fill,
              "transform" => "translate(#{x*x_size/2 - x_size/2},#{dy - 6*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})",
              "style" => {
                "opacity" => opacity
              }
            })
          end 

          # These can hang off the bottom, so put a row at the top for tiling.
          if (y == 5)
            @svg.group(x_shape, {
              "fill"  => fill,
              "transform" => "translate(#{x*x_size/2 - x_size/2},#{dy - 11*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})",
              "style" => {
                "opacity" => opacity
              }
            })
          end 

          # Add an extra one at top-right and bottom-right, for tiling.
          if (x == 0 && y == 0)
            @svg.group(x_shape, {
              "fill"  => fill,
              "transform" => "translate(#{6*x_size/2 - x_size/2},#{dy - 6*x_size/2}) rotate(45, #{x_size/2}, #{x_size/2})",
              "style" => {
                "opacity" => opacity
              }
            })
          end 
          i += 1
        end 
      end 
    end

    def geo_overlapping_circles
      scale    = @hash[1, 1].to_i(16)
      diameter = map(scale, 0, 15, 20, 200)
      radius   = diameter/2;

      @svg.set_width(radius * 6)
      @svg.set_height(radius * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = @hash[i, 1].to_i(16)
          opacity = map(val, 0, 15, 0.02, 0.1)
          fill    = (val % 2 == 0) ? "#ddd" : "#222"
          @svg.circle(x*radius, y*radius, radius, {
            "fill"  => fill,
            "style" => {
              "opacity" => opacity
            }
          })

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            @svg.circle(6*radius, y*radius, radius, {
              "fill"  => fill,
              "style" => {
                "opacity" => opacity
              }
            })
          end 

          # Add an extra row at the end that matches the first row, for tiling.
          if (y == 0)
            @svg.circle(x*radius, 6*radius, radius, {
              "fill"  => fill,
              "style" => {
                "opacity" => opacity
              }
            })
          end

          # Add an extra one at bottom-right, for tiling.
          if (x == 0 and y == 0)
            @svg.circle(6*radius, 6*radius, radius, {
              "fill"  => fill,
              "style" => {
                "opacity" => opacity
              }
            })
          end 
          i += 1
        end 
      end
    end 

    def geo_squares
      square_size = map(@hash[0, 1].to_i(16), 0, 15, 10, 70)

      @svg.set_width(square_size * 6)
      @svg.set_height(square_size * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = @hash[i, 1].to_i(16)
          opacity = map(val, 0, 15, 0.02, 0.2)
          fill    = (val % 2 == 0) ? "#ddd" : "#222"

          @svg.rect(x*square_size, y*square_size, square_size, square_size, {
            "fill"  => fill,
            "style" => {
              "opacity" => opacity
            }
          })
          i += 1
        end
      end
    end

    def geo_rings
      scale        = @hash[1, 1].to_i(16)
      ring_size    = map(scale, 0, 15, 5, 80)
      stroke_width = ring_size / 4

      @svg.set_width((ring_size + stroke_width) * 6)
      @svg.set_height((ring_size + stroke_width) * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = @hash[i, 1].to_i(16)
          opacity = map(val, 0, 15, 0.02, 0.16)

          @svg.circle(
                  x*ring_size + x*stroke_width + (ring_size + stroke_width)/2,
                  y*ring_size + y*stroke_width + (ring_size + stroke_width)/2,
                  ring_size/2, {
                    "fill"  => "none",
                    "stroke" => "#000",
                    "style" => {
                      "opacity" => opacity,
                      "stroke-width" => "#{stroke_width}px"
                    }
                  })
          i += 1
        end
      end
    end

    def geo_triangles
      scale           = @hash[1, 1].to_i(16)
      side_length     = map(scale, 0, 15, 5, 120)
      triangle_height = side_length/2 * Math.sqrt(3)
      triangle        = build_triangle_shape(side_length, triangle_height)

      @svg.set_width(side_length * 3)
      @svg.set_height(triangle_height * 6)

      i = 0
      for y in 0..5
        for x in 0..5
          val     = @hash[i, 1].to_i(16)
          opacity = map(val, 0, 15, 0.02, 0.15)
          fill    = (val % 2 == 0) ? "#ddd" : "#222"

          rotation = ""
          if y % 2 == 0
            rotation = x % 2 == 0 ? 180 : 0
          else
            rotation = x % 2 != 0 ? 180 : 0 
          end 

          tmp_tri = String.new(triangle)
          @svg.polyline(tmp_tri, {
            "opacity"   => opacity,
            "fill"      => fill,
            "stroke"    => "#444",
            "transform" => "translate(#{x*side_length*0.5 - side_length/2}, #{triangle_height*y}) rotate(#{rotation}, #{side_length/2}, #{triangle_height/2})"
          })

          # Add an extra one at top-right, for tiling.
          if (x == 0)
            tmp_tri = String.new(triangle)
            @svg.polyline(tmp_tri, {
              "opacity"   => opacity,
              "fill"      => fill,
              "stroke"    => "#444",
              "transform" => "translate(#{6*side_length*0.5 - side_length/2}, #{triangle_height*y}) rotate(#{rotation}, #{side_length/2}, #{triangle_height/2})"
            })
          end 
          i += 1
        end
      end
    end

    def build_hexagon_shape(sideLength)
      c = sideLength
      a = c/2
      b = Math.sin(60 * Math::PI / 180)*c
      "0,#{b},#{a},0,#{a+c},0,#{2*c},#{b},#{a+c},#{2*b},#{a},#{2*b},0,#{b}"
    end

    def build_x_shape(square_size)
      [
        "rect(#{square_size},0,#{square_size},#{square_size * 3})",
        "rect(0, #{square_size},#{square_size * 3},#{square_size})"
      ]
    end

    def build_triangle_shape(side_length, height)
      half_width = side_length / 2
      "#{half_width}, 0, #{side_length}, #{height}, 0, #{height}, #{half_width}, 0"
    end

    # Ruby implementation of Processing's map function
    # http://processing.org/reference/map_.html
    def map(value, v_min, v_max, d_min, d_max) # v for value, d for desired
      v_value = value.to_f # so it returns float

      v_range = v_max - v_min
      d_range = d_max - d_min
      d_value = (v_value - v_min) * d_range / v_range + d_min
    end
  end
end
