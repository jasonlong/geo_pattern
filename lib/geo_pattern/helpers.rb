module GeoPattern
  module Helpers
    def require_files_matching_pattern(pattern)
      Dir.glob(pattern).each { |f| require_relative f }
    end

    def underscore(camel_cased_word)
      return camel_cased_word unless camel_cased_word =~ /[A-Z-]/

      word = camel_cased_word.to_s

      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')

      word.downcase!

      word
    end

    module_function :underscore
  end
end
