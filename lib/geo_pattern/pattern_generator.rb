module GeoPattern
  class PatternGenerator

    private

    attr_reader :opts, :seed, :base_color, :pattern_preset, :color_preset

    public

    def initialize(string, opts = {})
      @opts = opts

      @pattern_preset = PatternPreset.new(
        fill_color_dark: '#222',
        fill_color_light: '#ddd',
        stroke_color: '#000',
        stroke_opacity: 0.02,
        opacity_min: 0.02,
        opacity_max: 0.15
      )

      @color_preset = ColorPreset.new(
        base_color: '#933c3c'
      )
      @color_preset.update opts
      @seed             = Seed.new(string)

      generate_pattern
    end

    def svg_string
      @svg.to_s
    end
    alias_method :to_s, :svg_string

    def base64_string
      Base64.strict_encode64(svg_string)
    end

    def uri_image
      "url(data:image/svg+xml;base64,#{base64_string});"
    end

    private

    def generate_pattern
      puts SVG.as_comment('Using generator key is deprecated as of 1.3.1') if opts.key? :generator

      requested_patterns = (Array(opts[:generator]) | Array(opts[:patterns])).flatten.compact

      # @svg = SVG.new
      # @svg << Generators::BackgroundGenerator.new(seed, color_preset).generate
      background_generator = Generators::BackgroundGenerator.new(seed, color_preset)

      pattern = Pattern.new
      pattern.add_background(background_generator)

      validator = PatternValidator.new
      validator.validate(requested_patterns)

      sieve = PatternSieve.new
      patterns = sieve.fetch(requested_patterns)

      generator_klass = patterns[[PatternHelpers.hex_val(seed, 20, 1), patterns.length - 1].min]
      structure_generator = generator_klass.new(seed, pattern_preset)

      pattern.add_structure(structure_generator)

      @svg = pattern.to_svg_raw
    end
  end
end
