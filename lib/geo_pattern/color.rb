# frozen_string_literal: true

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

      format("rgb(%<r>d, %<g>d, %<b>d)", r: r, g: g, b: b)
    end

    def to_html
      color.html
    end
  end
end
