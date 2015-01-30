module GeoPattern
  class Background
    include Roles::ComparableMetadata

    extend Forwardable

    attr_reader :image, :preset, :color

    def_delegators :@preset, :base_color, :color

    def initialize(options)
      @image     = options[:image]
      @preset    = options[:preset]
      @color     = options[:color]
      @generator = options[:generator]
    end

    def_comparators :base_color, :color
  end
end
