# frozen_string_literal: true

module GeoPattern
  module PatternHelpers
    def hex_val(hash, index, length)
      hash[index, length || 1].to_i(16)
    end

    # Ruby implementation of Processing's map function
    # http://processing.org/reference/map_.html
    # v for value, d for desired
    def map(value, v_min, v_max, d_min, d_max)
      v_value = value.to_f # so it returns float

      v_range = v_max - v_min
      d_range = d_max - d_min
      (v_value - v_min) * d_range / v_range + d_min
    end

    def html_to_rgb(color)
      generate_rgb_string(::Color::RGB.from_html(color))
    end

    def html_to_rgb_for_string(seed, base_color)
      hue_offset = map(seed.to_i(14, 3), 0, 4095, 0, 359)
      sat_offset = seed.to_i(17, 1)

      generate_rgb_string(offset_color(base_color, hue_offset, sat_offset))
    end

    # Rotates the hue and shifts the saturation of an HTML color, returning a
    # Color::RGB. Color objects are immutable as of color 2.0, so this builds a
    # new color instead of mutating one in place.
    def offset_color(html_color, hue_offset, sat_offset)
      hsl = ::Color::RGB.from_html(html_color).to_hsl

      hue = (hsl.hue - hue_offset) / 360.0
      hue += 1.0 if hue < 0.0
      hue -= 1.0 if hue > 1.0

      saturation = if sat_offset % 2 == 0
        hsl.saturation + sat_offset
      else
        hsl.saturation - sat_offset
      end

      ::Color::HSL.from_fraction(
        hue.clamp(0.0, 1.0),
        (saturation / 100.0).clamp(0.0, 1.0),
        hsl.l
      ).to_rgb
    end

    def generate_rgb_string(rgb)
      r = (rgb.r * 255).round
      g = (rgb.g * 255).round
      b = (rgb.b * 255).round

      format("rgb(%<r>d, %<g>d, %<b>d)", r: r, g: g, b: b)
    end

    module_function :hex_val, :map, :html_to_rgb, :html_to_rgb_for_string, :offset_color, :generate_rgb_string
  end
end
