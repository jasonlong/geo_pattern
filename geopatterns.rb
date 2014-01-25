require 'color'

class GitHub::SVG
  def initialize(width, height)
    @width  ||= 100
    @height ||= 100
    @str      = ""
  end
end

class GeoPattern
  def initialize(sha)
    @hash = sha
    @svg  = GitHub::SVG.new
    # generate_colors
    geoSineWaves
  end

  def svg_header
    "<svg xmlns='http://www.w3.org/2000/svg' width='240' height='1080'>"
  end

  def svg_closer
    "</svg>"
  end

  def svg_string
    svg_header + @svg + svg_closer
  end

  def geoSineWaves
    @svg << "<path d='M0 44 C 42 0, 78 0, 120 44 S 198 88, 240 44 S 318 0, 360, 44' fill='none' stroke='#dddddd' transform='matrix(1,0,0,1,-60,1014)' style='opacity: 0.02; stroke-width: 30px;'/>"
  end

  def generate_colors
    # use values at the end of the hash to determine HSL values
    base_hue = map(@hash[25, 3].to_i(16), 0, 4095, 0, 360)
    base_sat = map(@hash[28, 2].to_i(16), 0, 255, 0, 20)
    base_lum = map(@hash[30, 2].to_i(16), 0, 255, 0, 20)

    base_color = Color::HSL.new(base_hue, 50 - base_sat, 90 - base_lum)
    rgb = base_color.to_rgb
    r = (rgb.r * 255).round
    g = (rgb.g * 255).round
    b = (rgb.b * 255).round

    i_color = base_color
    i_color.saturation = i_color.saturation + 15
    i_color.luminosity = i_color.luminosity - 15

    i_rgb = base_color.to_rgb
    i_r = (i_rgb.r * 255).round
    i_g = (i_rgb.g * 255).round
    i_b = (i_rgb.b * 255).round

    # @bg_color      = ChunkyPNG::Color.rgb(240, 240, 240)
    # @invader_color = ChunkyPNG::Color.rgb(i_r, i_g, i_b)
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

pattern = GeoPattern.new("073f59b119f21d1c2a35435d08e7894aa6a0c1cb")
data = pattern.svg_string
puts data
