module GeoPattern
  class Background
    extend Forwardable

    attr_reader :image, :preset, :color

    def_delegators :@preset, *Helpers.build_arguments(:base_color, :color)

    def initialize(options)
      @image     = options[:image]
      @preset    = options[:preset]
      @color     = options[:color]
      @generator = options[:generator]
    end
  end
end
