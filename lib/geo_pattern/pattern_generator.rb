require 'base64'
require 'digest/sha1'
require 'color'

module GeoPattern
  class PatternGenerator
    DEFAULTS = {
      :base_color => '#933c3c'
    }

    PATTERNS = [
      ChevronPattern,
      ConcentricCirclesPattern,
      DiamondsPattern,
      HexagonPattern,
      MosaicSquaresPattern,
      NestedSquaresPattern,
      OctagonPattern,
      OverlappingCirclesPattern,
      OverlappingRingsPattern,
      PlaidPattern,
      PlusSignPattern,
      SineWavePattern,
      TessellationPattern,
      XesPattern
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
    alias_method :to_s, :svg_string

    def base64_string
      Base64.strict_encode64(svg_string)
    end

    def uri_image
      "url(data:image/svg+xml;base64,#{base64_string});"
    end

    def generate_background
      if opts[:color]
        rgb = Color::RGB.from_html(opts[:color])
      else
        hue_offset     = PatternHelpers.map(PatternHelpers.hex_val(hash, 14, 3), 0, 4095, 0, 359)
        sat_offset     = PatternHelpers.hex_val(hash, 17, 1)
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
      # Use the given pattern, if available
      generator = opts[:generator] if PATTERNS.include?(opts[:generator])

      # Ensure that the pattern exists, if not, abort with an err
      if generator.nil? and opts[:generator]
        abort("Error: the requested generator is invalid")
      else
        generator = PATTERNS[[PatternHelpers.hex_val(hash, 20, 1), PATTERNS.length - 1].min]
      end

      # Instantiate the generator with the needed references
      # and render the pattern to the svg object
      generator.new(svg, hash).render_to_svg
    end
  end
end
