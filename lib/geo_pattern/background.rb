module GeoPattern
  class Background
    include Roles::ComparableMetadata

    extend Forwardable

    attr_reader :image, :preset, :color, :generator

    def_delegators :@preset, :base_color

    def initialize(options)
      @image     = options[:image]
      @preset    = options[:preset]
      @color     = options[:color]
      @generator = options[:generator]

      raise ArgumentError, 'Argument color is missing' if @color.nil?
      raise ArgumentError, 'Argument image is missing' if @image.nil?
      raise ArgumentError, 'Argument preset is missing' if @preset.nil?
      raise ArgumentError, 'Argument generator is missing' if @generator.nil?
    end

    def_comparators :base_color, :color
  end
end
