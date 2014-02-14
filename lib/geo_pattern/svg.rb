module GeoPattern
  class SVG
    def initialize
      @width      = 100
      @height     = 100
      @svg_string = ""
    end

    def set_width(width)
      @width = width.floor
    end

    def set_height(height)
      @height = height.floor
    end

    def svg_header
      %Q{<svg xmlns="http://www.w3.org/2000/svg" width="#{@width}" height="#{@height}">}
    end

    def svg_closer
      "</svg>"
    end

    def to_s
      svg_header + @svg_string + svg_closer
    end

    def rect(x, y, width, height, args={})
      @svg_string << %Q{<rect x="#{x}" y="#{y}" width="#{width}" height="#{height}" #{write_args(args)} />}
    end

    def circle(cx, cy, r, args={})
      @svg_string << %Q{<circle cx="#{cx}" cy="#{cy}" r="#{r}" #{write_args(args)} />}
    end

    def path(str, args={})
      @svg_string << %Q{<path d="#{str}" #{write_args(args)} />}
    end

    def polyline(str, args={})
      @svg_string << %Q{<polyline points="#{str}" #{write_args(args)} />}
    end

    def group(elements, args={})
      @svg_string << %Q{<g #{write_args(args)}>}
      elements.each {|e| eval e}
      @svg_string << %Q{</g>}
    end

    def write_args(args)
      str = ""
      args.each {|key, value|
        if value.is_a?(Hash)
          str << %Q{#{key}="}
          value.each {|k, v|
            str << %Q{#{k}:#{v};}
          } 
          str << %Q{" }
        else
          str << %Q{#{key}="#{value}" }
        end
      }
      str
    end
  end
end
