module GeoPattern
  module PatternHelpers
    def hex_val(hash, index, length)
      hash[index, length || 1].to_i(16)
    end

    # Ruby implementation of Processing's map function
    # http://processing.org/reference/map_.html
    def map(value, v_min, v_max, d_min, d_max) # v for value, d for desired
      v_value = value.to_f # so it returns float

      v_range = v_max - v_min
      d_range = d_max - d_min
      (v_value - v_min) * d_range / v_range + d_min
    end

    def html_to_rgb(color)
      generate_rgb_string(::Color::RGB.from_html(color))
    end

    def html_to_rgb_for_string(seed, base_color)
      hue_offset     = map(seed.to_i(14, 3), 0, 4095, 0, 359)
      sat_offset     = seed.to_i(17, 1)
      base_color     = ::Color::RGB.from_html(base_color).to_hsl
      base_color.hue = base_color.hue - hue_offset

      base_color.saturation = if sat_offset % 2 == 0
                                base_color.saturation + sat_offset
                              else
                                base_color.saturation - sat_offset
                              end

      generate_rgb_string(base_color.to_rgb)
    end

    def generate_rgb_string(rgb)
      r = (rgb.r * 255).round
      g = (rgb.g * 255).round
      b = (rgb.b * 255).round

      format('rgb(%d, %d, %d)', r, g, b)
    end

    module_function :hex_val, :map, :html_to_rgb, :html_to_rgb_for_string, :generate_rgb_string
  end
end
