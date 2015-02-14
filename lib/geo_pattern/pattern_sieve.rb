module GeoPattern
  class PatternSieve
    private

    attr_reader :pattern_store, :requested_patterns, :seed, :available_patterns, :index

    public

    def initialize(requested_patterns, seed, pattern_store = PatternStore.new)
      @requested_patterns = requested_patterns
      @seed               = seed
      @pattern_store      = pattern_store

      @available_patterns = determine_available_patterns
      @index              = determine_index
    end

    def fetch
      available_patterns[index]
    end

    private

    def determine_index
      [seed.to_i(20, 1), available_patterns.length - 1].min
    end

    def determine_available_patterns
      patterns = Array(requested_patterns).compact

      return pattern_store.all if patterns.empty?

      patterns.map { |p| pattern_store[p] }.compact
    end
  end
end
