module GeoPattern
  class Seed
    private

    attr_reader :seed

    public

    def initialize(string)
      @seed = Digest::SHA1.hexdigest string.to_s
    end

    def to_s
      seed
    end

    def [](*args)
      seed[*args]
    end
  end
end
