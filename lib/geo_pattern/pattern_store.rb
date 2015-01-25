module GeoPattern
  class PatternStore
    private

    attr_reader :store

    public

    def initialize(
      store = HashStore.new(
        chevrons: ChevronPattern,
        concentric_circles: ConcentricCirclesPattern,
        diamonds:  DiamondPattern,
        hexagons:  HexagonPattern,
        mosaic_squares:  MosaicSquaresPattern,
        nested_squares:  NestedSquaresPattern,
        octagons:  OctagonPattern,
        overlapping_circles:  OverlappingCirclesPattern,
        overlapping_rings:  OverlappingRingsPattern,
        plaid:  PlaidPattern,
        plus_signs:  PlusSignPattern,
        sine_waves:  SineWavePattern,
        squares:  SquarePattern,
        tessellation:  TessellationPattern,
        triangles:  TrianglePattern,
        xes:  XesPattern
      )
    )

      @store = store
    end

    def [](pattern)
      if pattern.kind_of?(String ) || pattern.kind_of?(Symbol)
        $stderr.puts 'String pattern references are deprecated as of 1.3.0' 
        return store[pattern]
      end

      return pattern if store.value? pattern

      nil
    end

    def all
      store.values
    end

    def known?(pattern)
      return store.key?(pattern) if pattern.kind_of?(String) || pattern.kind_of?(Symbol)
      return store.value?(pattern) if pattern.kind_of? Class

      false
    end
  end
end
