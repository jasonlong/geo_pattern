module GeoPattern
  class PatternDb
    private

    attr_reader :db

    public

    def initialize
      @db = {
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
      db.count
    end

    def all
      db.values
    end

    def fetch(*patterns)
      patterns = patterns.flatten

      return all if patterns.empty?

      output_warning = false
      abort("Error: the requested generator is invalid") unless valid?(patterns)

      result = patterns.map do |p|
        if p.kind_of? String
          output_warning = true

          db[p]
        else
          p
        end
      end

      puts SVG.as_comment("String pattern references are deprecated as of 1.3.0") if output_warning

      result
    end

    private

    def valid?(patterns)
      return false unless (patterns.select { |p| p.kind_of? String } - db.keys).empty?
      return false unless (patterns.select { |p| p.kind_of? Class } - db.values).empty?

      true
    end
  end
end
