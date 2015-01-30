module GeoPattern
  class PatternPreset
    private

    attr_accessor :options

    public

    def initialize(options)
      @options = options
    end

    [:fill_color_dark, :fill_color_light, :stroke_color, :stroke_opacity, :opacity_min, :opacity_max].each do |m|
      define_method m do
        options[m]
      end
    end

    def update(opts)
      options.merge! opts
    end
  end
end
