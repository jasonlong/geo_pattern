module GeoPattern
  class PatternGenerator

    private

    attr_reader :seed, :base_color, :pattern_preset, :color_preset, :requested_patterns

    public

    def initialize(string, opts = {})
      $stderr.puts 'Using generator key is deprecated as of 1.3.1' if opts.key? :generator

      @requested_patterns = (Array(opts[:generator]) | Array(opts[:patterns])).flatten.compact

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

      @seed = Seed.new(string)
    end

    def generate
      pattern = Pattern.new

      pattern.generate_me background_generator
      pattern.generate_me structure_generator

      pattern
    end

    private

    def validator
      PatternValidator.new
    end

    def pattern_sieve
      PatternSieve.new(requested_patterns, seed)
    end

    def background_generator
      Generators::BackgroundGenerator.new(seed, color_preset)
    end

    def structure_generator
      validator.validate(requested_patterns)
      generator_klass = pattern_sieve.fetch
      generator_klass.new(seed, pattern_preset)
    end

  end
end
