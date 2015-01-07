module SpecHelpers
  def html_to_rgb(color)
    generate_rgb_string(Color::RGB.from_html(color))
  end

  def html_to_rgb_for_string(string, base_color)
    hash = Digest::SHA1.hexdigest string

    hue_offset     = GeoPattern::PatternHelpers.map(GeoPattern::PatternHelpers.hex_val(hash, 14, 3), 0, 4095, 0, 359)
    sat_offset     = GeoPattern::PatternHelpers.hex_val(hash, 17, 1)
    base_color     = Color::RGB.from_html(base_color).to_hsl
    base_color.hue = base_color.hue - hue_offset;

    if (sat_offset % 2 == 0)
      base_color.saturation = base_color.saturation + sat_offset
    else
      base_color.saturation = base_color.saturation - sat_offset
    end

    generate_rgb_string(base_color.to_rgb)
  end

  def generate_rgb_string(rgb)
    r = (rgb.r * 255).round
    g = (rgb.g * 255).round
    b = (rgb.b * 255).round

    format("rgb(%d, %d, %d)", r, g, b)
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end
