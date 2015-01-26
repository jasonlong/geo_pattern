module GeoPattern
  class Pattern
    private

    attr_reader :svg
    attr_accessor :background, :structure

    public

    def initialize(svg = SVG.new)
      @svg = svg
    end

    def add_background(generator)
      self.background =  generator.generate
    end

    def add_structure(generator)
      self.structure = generator.generate
    end

    def to_svg_raw
      svg << background if background
      svg << structure if structure

      svg
    end
  end
end
