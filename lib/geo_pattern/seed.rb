module GeoPattern
  class Seed
    private

    attr_reader :seed

    public

    def initialize(string)
      @seed = Digest::SHA1.hexdigest string.to_s
    end

    def [](*args)
      seed[*args]
    end

    def to_i(index, length)
      seed[index, length || 1].to_i(16)
    end
  end
end
