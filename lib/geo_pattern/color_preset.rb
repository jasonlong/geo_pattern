module GeoPattern
  class ColorPreset

    private

    attr_accessor :options

    public

    def initialize(options)
      @options = options
    end

    [:base_color, :color].each do |m|
      define_method m do
        options[m]
      end
    end

    def color?
      !options[:color].nil? && !options[:color].empty?
    end

    def update(opts)
      options.merge! opts
    end
  end
end
