module GeoPattern
  class Pattern
    private

    attr_reader :svg
    attr_accessor :background

    public

    def initialize(svg = SVG.new)
      @svg = svg
    end

    def add_background(generator)
      self.background =  generator.generate
    end

    def to_svg_raw
      svg << background

      svg
    end
  end
end
