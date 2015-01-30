module GeoPattern
  class Structure
    extend Forwardable

    attr_reader :image, :preset, :name, :generator

    def_delegators :@preset, :fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max

    def initialize(options)
      @image     = options[:image]
      @preset    = options[:preset]
      @name      = options[:name]
      @generator = options[:generator]

      fail ArgumentError, 'Argument name is missing' if @name.nil?
      fail ArgumentError, 'Argument image is missing' if @image.nil?
      fail ArgumentError, 'Argument preset is missing' if @preset.nil?
      fail ArgumentError, 'Argument generator is missing' if @generator.nil?
    end


    [:name, :fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max].each do |m|
      define_method "#{m}?".to_sym do |value|
        return true if value.nil? && public_send(m)
        return true if value == public_send(m)

        false
      end
    end

    def generator?(value)
      return false unless value.kind_of?(Class) || value == nil
      return true if value.nil? && @generator

      return true if value == generator

      false
    end
  end
end
