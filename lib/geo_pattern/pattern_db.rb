module GeoPattern
  class PatternDb
    private

    attr_reader :patterns

    public

    def initialize
      @patterns = {
        'chevrons'            => ChevronPattern,
        'concentric_circles'  => ConcentricCirclesPattern,
        'diamonds'            => DiamondPattern,
        'hexagons'            => HexagonPattern,
        'mosaic_squares'      => MosaicSquaresPattern,
        'nested_squares'      => NestedSquaresPattern,
        'octagons'            => OctagonPattern,
        'overlapping_circles' => OverlappingCirclesPattern,
        'overlapping_rings'   => OverlappingRingsPattern,
        'plaid'               => PlaidPattern,
        'plus_signs'          => PlusSignPattern,
        'sine_waves'          => SineWavePattern,
        'squares'             => SquarePattern,
        'tessellation'        => TessellationPattern,
        'triangles'           => TrianglePattern,
        'xes'                 => XesPattern
      }.freeze
    end

    def count
      patterns.count
    end

    def all
      patterns.values
    end

    def fetch(*patterns)
      patterns = patterns.flatten

      return all if patterns.empty?

      output_warning = false
      abort("Error: At least one of the requested patterns \"#{patterns.join(", ")}\" is invalid") unless valid?(patterns)

      result = patterns.map do |pattern|
        if pattern.kind_of? String
          output_warning = true

          patterns[pattern]
        else
          pattern
        end
      end

      puts SVG.as_comment("String pattern references are deprecated as of 1.3.0") if output_warning

      result
    end

    private

    def valid?(requested_patterns)
      return false unless (requested_patterns.select { |p| p.kind_of? String } - patterns.keys).empty?
      return false unless (requested_patterns.select { |p| p.kind_of? Class } - patterns.values).empty?

      true
    end
  end
end
