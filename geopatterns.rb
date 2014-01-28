require 'base64'
require 'digest/sha1'
require 'color'

class SVG
  def initialize
    @width      = 100
    @height     = 100
    @svg_string = ""
  end

  def set_width(width)
    @width = width
  end

  def set_height(height)
    @height = height
  end

  def svg_header
    %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{@width}" height="#{@height}">}
  end

  def svg_closer
    "</svg>"
  end

  def to_s
    svg_header + @svg_string + svg_closer
  end

  def rect(x, y, width, height, args={})
    @svg_string << %Q{<rect x="#{x}" y="#{y}" width="#{width}" height="#{height}" #{write_args(args)} />}
  end

  def circle(cx, cy, r, args={})
    @svg_string << %Q{<circle cx="#{cx}" cy="#{cy}" r="#{r}" #{write_args(args)} />}
  end

  def path(str, args={})
    @svg_string << %Q{<path d="#{str}" #{write_args(args)} />}
  end

  def write_args(args)
    str = ""
    args.each {|key, value|
      if value.is_a?(Hash)
        str << %Q{#{key}="}
        value.each {|key, value|
          str << %Q{#{key}:#{value};}
        }
        str << %Q{"}
      else
        str << %Q{#{key}="#{value}" }
      end
    }
    str
  end
end

class GeoPattern
  def initialize(string)
    @hash = Digest::SHA1.hexdigest string
    @svg  = SVG.new
    generate_background
    # geoSineWaves
    geoOverlappingCircles
  end

  def svg_string
    @svg.to_s
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

  def geoSineWaves
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

  def geoOverlappingCircles
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

  # Ruby implementation of Processing's map function
  # http://processing.org/reference/map_.html
  def map(value, v_min, v_max, d_min, d_max) # v for value, d for desired
    v_value = value.to_f # so it returns float

    v_range = v_max - v_min
    d_range = d_max - d_min
    d_value = (v_value - v_min) * d_range / v_range + d_min
  end
end

pattern = GeoPattern.new("Getting your project on GitHub")
data = pattern.svg_string
puts data
