module GeoPattern
  class PatternStore
    private

    attr_reader :store

    public

    def initialize(
      store = HashStore.new(
        chevrons: StructureGenerators::ChevronsGenerator,
        concentric_circles: StructureGenerators::ConcentricCirclesGenerator,
        diamonds: StructureGenerators::DiamondsGenerator,
        hexagons: StructureGenerators::HexagonsGenerator,
        mosaic_squares: StructureGenerators::MosaicSquaresGenerator,
        nested_squares: StructureGenerators::NestedSquaresGenerator,
        octagons: StructureGenerators::OctagonsGenerator,
        overlapping_circles: StructureGenerators::OverlappingCirclesGenerator,
        overlapping_rings: StructureGenerators::OverlappingRingsGenerator,
        plaid: StructureGenerators::PlaidGenerator,
        plus_signs: StructureGenerators::PlusSignsGenerator,
        sine_waves: StructureGenerators::SineWavesGenerator,
        squares: StructureGenerators::SquaresGenerator,
        tessellation: StructureGenerators::TessellationGenerator,
        triangles: StructureGenerators::TrianglesGenerator,
        xes: StructureGenerators::XesGenerator
      )
    )

      @store = store
    end

    def [](pattern)
      if pattern.is_a?(String) || pattern.is_a?(Symbol)
        $stderr.puts 'String pattern references are deprecated as of 1.3.0' if pattern.is_a?(String)

        return store[pattern]
      end

      if store.value? pattern
        $stderr.puts 'Class pattern references are deprecated as of 1.3.0'

        return pattern
      end

      nil
    end

    def all
      store.values
    end

    def known?(pattern)
      return store.key?(pattern) if pattern.is_a?(String) || pattern.is_a?(Symbol)
      return store.value?(pattern) if pattern.is_a? Class

      false
    end
  end
end
