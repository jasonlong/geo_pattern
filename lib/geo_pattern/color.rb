module GeoPattern
  class Color
    private

    attr_accessor :color

    public

    def initialize(html_color)
      @color = ::Color::RGB.from_html html_color
    end

    def to_svg
      r = (color.r * 255).round
      g = (color.g * 255).round
      b = (color.b * 255).round

      format('rgb(%d, %d, %d)', r, g, b)
    end

    def to_html
      color.html
    end

    def transform_with(seed)
      hue_offset    = map(seed.to_i(14, 3), 0, 4095, 0, 359)
      sat_offset    = seed.to_i(17, 1)
      new_color     = color.to_hsl
      new_color.hue = new_color.hue - hue_offset

      if (sat_offset % 2 == 0)
        new_color.saturation = new_color.saturation + sat_offset
      else
        new_color.saturation = new_color.saturation - sat_offset
      end

      self.color = new_color.to_rgb
    end

    private

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
