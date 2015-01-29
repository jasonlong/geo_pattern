module GeoPattern
  class Background
    attr_reader :image, :preset, :color

    def initialize(options)
      @image  = options[:image]
      @preset = options[:preset]
      @color  = options[:color]
      @generator = options[:generator]
    end
  end
end
