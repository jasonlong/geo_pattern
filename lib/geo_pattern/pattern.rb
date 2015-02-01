module GeoPattern
  class Pattern
    private

    attr_reader :svg_image

    public

    attr_accessor :background, :structure, :height, :width

    def initialize(svg_image = SvgImage.new)
      @svg_image = svg_image
    end

    # Check if string is included in pattern
    #
    # @param [String] string
    #   The checked string
    def include?(string)
      image.include?(string)
    end

    # Generate things for the pattern
    #
    # @param [#generate) generator
    #   The generator which should do things with this pattern - e.g. adding
    #   background or a structure
    def generate_me(generator)
      generator.generate self
    end

    # Convert pattern to svg
    def to_svg
      image.to_s
    end
    alias_method :to_s, :to_svg

    # Convert to base64
    def to_base64
      Base64.strict_encode64(to_svg)
    end

    # Convert to data uri
    def to_data_uri
      "url(data:image/svg+xml;base64,#{to_base64});"
    end

    # @see #to_data_uri
    # @deprecated
    def uri_image
      $stderr.puts 'Using "#uri_image" is deprecated as of 1.3.1. Please use "#to_data_uri" instead.'

      to_data_uri
    end

    # @see #to_svg
    # @deprecated
    def svg_string
      $stderr.puts 'Using "#svg_string" is deprecated as of 1.3.1. Please use "#to_svg" instead.'

      to_svg
    end

    # @see #to_base64
    # @deprecated
    def base64_string
      $stderr.puts 'Using "#base64_string" is deprecated as of 1.3.1. Please use "#to_base64" instead.'

      to_base64
    end

    private

    def image
      svg_image.height = height
      svg_image.width  = width

      svg_image << background.image if background
      svg_image << structure.image if structure

      svg_image
    end
  end
end
