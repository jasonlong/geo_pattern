module GeoPattern
  class BasePattern < Struct.new(:svg, :hash)
    FILL_COLOR_DARK  = "#222"
    FILL_COLOR_LIGHT = "#ddd"
    STROKE_COLOR     = "#000"
    STROKE_OPACITY   = 0.02
    OPACITY_MIN      = 0.02
    OPACITY_MAX      = 0.15

    # Public: mutate the given `svg` object with a rendered pattern
    #
    # Note: this method _must_ be implemented by sub-
    # classes.
    #
    # svg - the SVG container
    #
    # Returns a reference to the same `svg` object
    # only this time with more patterns.
    def render_to_svg
      raise NotImplementedError
    end

    def hex_val(index, len)
      PatternHelpers.hex_val(hash, index, len)
    end

    def fill_color(val)
      (val.even?) ? FILL_COLOR_LIGHT : FILL_COLOR_DARK
    end

    def opacity(val)
      map(val, 0, 15, OPACITY_MIN, OPACITY_MAX)
    end

    def map(value, v_min, v_max, d_min, d_max)
      PatternHelpers.map(value, v_min, v_max, d_min, d_max)
    end

    protected
    def build_plus_shape(square_size)
      [
        "rect(#{square_size},0,#{square_size},#{square_size * 3})",
        "rect(0, #{square_size},#{square_size * 3},#{square_size})"
      ]
    end
  end
end
