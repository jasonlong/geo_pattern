module GeoPattern
  class PatternValidator
    private

    attr_reader :pattern_store

    public

    def initialize(pattern_store = PatternStore.new)
      @pattern_store = pattern_store
    end

    def validate(requested_patterns)
      message = "Error: At least one of the requested patterns \"#{requested_patterns.join(', ')}\" is invalid"

      raise InvalidPatternError, message unless valid?(requested_patterns)

      self
    end

    private

    def valid?(requested_patterns)
      requested_patterns.all? { |p| pattern_store.known? p }
    end
  end
end
