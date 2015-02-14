module GeoPattern
  module Helpers
    def require_files_matching_pattern(pattern)
      Dir.glob(pattern).each { |f| require_relative f }
    end

    # Makes an underscored, lowercase form from the expression in the string.
    #
    # @see ActiveSupport
    #   It's MIT-Licensed
    #
    def underscore(camel_cased_word)
      return camel_cased_word unless camel_cased_word =~ /[A-Z-]/

      word = camel_cased_word.to_s

      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2')

      word.downcase!

      word
    end

    # Removes the module part from the expression in the string.
    #
    # @see ActiveSupport
    #   It's MIT-Licensed
    #
    # @exmple Use demodulize
    #
    #   'ActiveRecord::CoreExtensions::String::Inflections'.demodulize # => "Inflections"
    #   'Inflections'.demodulize                                       # => "Inflections"
    #   '::Inflections'.demodulize                                     # => "Inflections"
    #   ''.demodulize                                                  # => ""
    #
    # See also +deconstantize+.
    def demodulize(path)
      path = path.to_s

      if i = path.rindex('::')
        path[(i + 2)..-1]
      else
        path
      end
    end

    def build_arguments(*methods)
      methods.flatten.map { |m| [m, "#{m}?"] }.flatten
    end

    module_function :underscore, :demodulize, :build_arguments, :require_files_matching_pattern
  end
end
