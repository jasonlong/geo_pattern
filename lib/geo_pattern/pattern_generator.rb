module GeoPattern
  class PatternGenerator

    private

    attr_reader :opts, :hash, :svg, :base_color, :fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max

    public

    def initialize(string, opts = {})
      @opts = {
        base_color: '#933c3c',
        fill_color_dark: '#222',
        fill_color_light: '#ddd',
        stroke_color: '#000',
        stroke_opacity: 0.02,
        opacity_min: 0.02,
        opacity_max: 0.15
      }.merge opts

      @base_color       = @opts[:base_color]
      @fill_color_dark  = @opts[:fill_color_dark]
      @fill_color_light = @opts[:fill_color_light]
      @stroke_color     = @opts[:stroke_color]
      @stroke_opacity   = @opts[:stroke_opacity]
      @opacity_min      = @opts[:opacity_min]
      @opacity_max      = @opts[:opacity_max]

      @hash             = Digest::SHA1.hexdigest string
      @svg              = SVG.new

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

    private

    def generate_background
      color = if opts[:color]
                PatternHelpers.html_to_rgb(opts[:color])
              else
                PatternHelpers.html_to_rgb_for_string(hash, opts[:base_color])
              end

      svg.rect(0, 0, "100%", "100%", "fill" => color)
    end

    def generate_pattern
      puts SVG.as_comment('Using generator key is deprecated as of 1.3.1') if opts.key? :generator

      requested_patterns = (Array(opts[:generator]) | Array(opts[:patterns])).flatten.compact

      validator = PatternValidator.new
      validator.validate(requested_patterns)

      sieve = PatternSieve.new
      patterns = sieve.fetch(requested_patterns)

      generator = patterns[[PatternHelpers.hex_val(hash, 20, 1), patterns.length - 1].min]

      # Instantiate the generator with the needed references
      # and render the pattern to the svg object
      generator.new(
        svg,
        hash,
        fill_color_dark: fill_color_dark,
        fill_color_light: fill_color_light,
        stroke_color: stroke_color,
        stroke_opacity: stroke_opacity,
        opacity_min: opacity_min,
        opacity_max: opacity_max
      ).render_to_svg
    end
  end
end
