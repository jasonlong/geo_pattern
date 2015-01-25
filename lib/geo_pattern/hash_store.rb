module GeoPattern
  class HashStore
    private

    attr_reader :hash

    public

    def initialize(hash)
      @hash = hash.each_with_object({}) { |(key, value), a| a[key.to_sym] = value }
    end

    def key?(obj)
      hash.key? obj.to_sym
    end

    def values
      hash.values
    end

    def value?(obj)
      hash.value? obj
    end

    def [](obj)
      hash[obj.to_sym]
    end
  end
end
