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
    end

    def generate
      puts SVG.as_comment('Using generator key is deprecated as of 1.3.1') if opts.key? :generator

      requested_patterns = (Array(opts[:generator]) | Array(opts[:patterns])).flatten.compact

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

      pattern
    end
  end
end
