module GeoPattern
  class Background
    attr_reader :image

    def initialize(options)
      @image  = options[:image]
      @preset = options[:preset]
      @color  = options[:color]
    end
  end
end
