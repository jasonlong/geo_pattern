module GeoPattern
  module Helpers
    def require_files_matching_pattern(pattern)
      Dir.glob(pattern).each { |f| require_relative f }
    end
  end
end
