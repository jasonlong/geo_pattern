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

      fail ArgumentError, :data if @options[:data].nil?

      @data             = @options[:data]
      @allowed_patterns = @options[:allowed_patterns]
    end

    # @private
    def run_task(_verbose)
      data.each do |path, string|
        path    = File.expand_path(path)
        patterns = if string.is_a? String
                     allowed_patterns
                   elsif string.is_a?(Array) && string.size > 1
                     string[1]
                   else
                     nil
                   end

        pattern = GeoPattern.generate(string, patterns: patterns)

        logger.info "Creating pattern at \"#{path}\"."
        FileUtils.mkdir_p File.dirname(path)
        File.write(path, pattern.to_svg)
      end
    end
  end
end
