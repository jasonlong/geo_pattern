module GeoPattern
  class PatternGenerator
    private

    attr_reader :background_generator, :structure_generator

    public

    def initialize(string, generator: nil, patterns: nil, base_color: nil, color: nil)
      $stderr.puts 'Using generator key is deprecated as of 1.3.1' if generator

      requested_patterns = (Array(generator) | Array(patterns)).flatten.compact

      pattern_preset = PatternPreset.new(
        fill_color_dark: '#222',
        fill_color_light: '#ddd',
        stroke_color: '#000',
        stroke_opacity: 0.02,
        opacity_min: 0.02,
        opacity_max: 0.15
      )

      color_preset = ColorPreset.new(
        base_color: '#933c3c'
      )
      color_preset.color      = color if color
      color_preset.base_color = base_color if base_color

      seed = Seed.new(string)

      pattern_validator = PatternValidator.new
      pattern_validator.validate(requested_patterns)

      pattern_sieve = PatternSieve.new(requested_patterns, seed)

      @background_generator = BackgroundGenerators::SolidGenerator.new(seed, color_preset)
      @structure_generator  = begin
                                generator_klass = pattern_sieve.fetch
                                generator_klass.new(seed, pattern_preset)
                              end
    end

    def generate
      pattern = Pattern.new

      pattern.generate_me background_generator
      pattern.generate_me structure_generator

      pattern
    end
  end
end
