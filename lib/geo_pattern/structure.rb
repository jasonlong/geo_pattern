module GeoPattern
  class Structure
    attr_reader :image, :preset

    def initialize(options)
      @image  = options[:image]
      @preset = options[:preset]
    end
  end
end
