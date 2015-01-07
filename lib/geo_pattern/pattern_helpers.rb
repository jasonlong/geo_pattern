module GeoPattern
  module PatternHelpers
    def self.hex_val(hash, index, length)
      hash[index, length || 1].to_i(16)
    end

    # Ruby implementation of Processing's map function
    # http://processing.org/reference/map_.html
    def self.map(value, v_min, v_max, d_min, d_max) # v for value, d for desired
      v_value = value.to_f # so it returns float

      v_range = v_max - v_min
      d_range = d_max - d_min
      (v_value - v_min) * d_range / v_range + d_min
    end
  end
end
