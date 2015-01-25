module GeoPattern
  class PatternSieve
    private

    attr_reader :pattern_store

    public

    def initialize(pattern_store = PatternStore.new)
      @pattern_store = pattern_store
    end

    def fetch(requested_patterns)
      requested_patterns = Array(requested_patterns).compact

      return pattern_store.all if requested_patterns.empty?

      requested_patterns.map { |p| pattern_store[p] }.compact
    end
  end
end
