module GeoPattern
  class Structure
    attr_reader :image, :preset, :name, :generator

    def initialize(options)
      @image  = options[:image]
      @preset = options[:preset]
      @name   = options[:name]
      @generator   = options[:generator]

      fail ArgumentError, 'Argument name is missing' if @name.nil?
      fail ArgumentError, 'Argument image is missing' if @image.nil?
      fail ArgumentError, 'Argument preset is missing' if @preset.nil?
      fail ArgumentError, 'Argument generator is missing' if @generator.nil?
    end

    def name?(value)
      return true if value.nil? && @name
      return true if value == name

      false
    end
  end
end
