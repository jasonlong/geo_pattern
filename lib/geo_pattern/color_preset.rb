module GeoPattern
  class ColorPreset
    attr_accessor :color, :base_color, :mode

    def initialize(color: nil, base_color: nil)
      @color      = color
      @base_color = base_color
    end

    # Return mode
    #
    # @return [Symbol]
    #   The color mode
    def mode
      if color.nil? || color.empty?
        :base_color
      else
        :color
      end
    end

    def mode?(m)
      mode == m
    end
  end
end
