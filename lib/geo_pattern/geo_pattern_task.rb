require 'geo_pattern'
require 'geo_pattern/rake_task'

module GeoPattern
  # GeoPatternTask
  #
  # @see Rakefile
  class GeoPatternTask < RakeTask
    # @!attribute [r] data
    #   The data which should be used to generate patterns
    attr_reader :data

    # @!attribute [r] allowed_patterns
    #   The the patterns which are allowed to be used
    attr_reader :allowed_patterns

    # Create a new geo pattern task
    #
    # @param [Hash] data
    #   The data which should be used to generate patterns
    #
    # @param [Array] allowed_patterns
    #   The allowed_patterns
    #
    # @see RakeTask
    #   For other arguments accepted
    def initialize(opts = {})
      super

      raise ArgumentError, :data if @options[:data].nil?

      @data             = @options[:data]
      @allowed_patterns = @options[:allowed_patterns]
    end

    # @private
    def run_task(_verbose)
      data.each do |path, string|
        opts = {}
        path = File.expand_path(path)

        if string.is_a?(Hash)
          input             = string[:input]
          opts[:patterns]   = string[:patterns] if string.key? :patterns
          opts[:color]      = string[:color] if string.key? :color
          opts[:base_color] = string[:base_color] if string.key? :base_color
        else
          raise 'Invalid data structure for Rake Task'
        end

        pattern = GeoPattern.generate(input, opts)

        logger.info "Creating pattern at \"#{path}\"."
        FileUtils.mkdir_p File.dirname(path)
        File.write(path, pattern.to_svg)
      end
    end
  end
end
