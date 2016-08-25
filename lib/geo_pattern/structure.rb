module GeoPattern
  class Structure
    include Roles::ComparableMetadata

    extend Forwardable

    attr_reader :image, :preset, :name, :generator

    def_delegators :@preset, :fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max

    def initialize(options)
      @image     = options[:image]
      @preset    = options[:preset]
      @name      = options[:name]
      @generator = options[:generator]

      raise ArgumentError, 'Argument name is missing' if @name.nil?
      raise ArgumentError, 'Argument image is missing' if @image.nil?
      raise ArgumentError, 'Argument preset is missing' if @preset.nil?
      raise ArgumentError, 'Argument generator is missing' if @generator.nil?
    end

    def_comparators :name, :fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max
  end
end
