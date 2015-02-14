module GeoPattern
  # rubocop:disable Style/ConstantName
  ChevronPattern            = :chevrons
  ConcentricCirclesPattern  = :concentric_circles
  DiamondPattern            = :diamonds
  HexagonPattern            = :hexagons
  MosaicSquaresPattern      = :mosaic_squares
  NestedSquaresPattern      = :nested_squares
  OctagonPattern            = :octagons
  OverlappingCirclesPattern = :overlapping_circles
  OverlappingRingsPattern   = :overlapping_rings
  PlaidPattern              = :plaid
  PlusSignPattern           = :plus_signs
  SineWavePattern           = :sine_waves
  SquarePattern             = :squares
  TessellationPattern       = :tessellation
  TrianglePattern           = :triangles
  XesPattern                = :xes
  # rubocop:enable Style/ConstantName

  class PatternStore
    private

    attr_reader :store

    public

    def initialize
      @store = {
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
      }
    end

    def [](pattern)
      $stderr.puts 'String pattern references are deprecated as of 1.3.0' if pattern.is_a?(String)

      store[pattern.to_s.to_sym]
    end

    def all
      store.values
    end

    def known?(pattern)
      store.key?(pattern.to_s.to_sym)
    end
  end
end
