# GeoPattern

Generate beautiful tiling SVG patterns from a string. The string is converted into a SHA and a color and pattern are determined based on the values in the hash. The color is determined by shifting the hue and saturation from a default (or passed in) base color. One of 16 patterns is used (or you can specify one) and the sizing of the pattern elements is also determined by the hash values.

You can use the generated pattern as the `background-image` for a container. Using the `base64` representation of the pattern still results in SVG rendering, so it looks great on retina displays.

See the [GitHub Guides](http://guides.github.com) site as an example of this library in action.

## Installation

Add this line to your application's Gemfile:

    gem 'geo_pattern'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geo_pattern

## Usage

Make a new pattern:

    pattern = GeoPattern.generate("Mastering Markdown")

To specify a base background color (with a hue and saturation that adjusts depending on the string):

    pattern = GeoPattern.generate("Mastering Markdown", {:base_color => "#fc0"})

To use a specific background color (w/o any hue or saturation adjustments):

    pattern = GeoPattern.generate("Mastering Markdown", {:color => "#fc0"})

To use a specific [pattern generator](#available-patterns):

    pattern = GeoPattern.generate("Mastering Markdown", {:generator => "sine_waves"})

Get the SVG string:

    puts pattern.svg_string
    # => <svg xmlns="http://www.w3.org/2000/svg" ...

Get the Base64 encoded string:

    puts pattern.base64_string
    # => PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC...

You can then use this string to set the background:

    <div style="background-image: <%=pattern.uri_image%>"></div>

## Available patterns

### octogons

![](http://jasonlong.github.io/geo_pattern/examples/octogons.png)

### overlapping_circles

![](http://jasonlong.github.io/geo_pattern/examples/overlapping_circles.png)

### plus_signs

![](http://jasonlong.github.io/geo_pattern/examples/plus_signs.png)

### xes

![](http://jasonlong.github.io/geo_pattern/examples/xes.png)

### sine_waves

![](http://jasonlong.github.io/geo_pattern/examples/sine_waves.png)

### hexagons

![](http://jasonlong.github.io/geo_pattern/examples/hexagons.png)

### overlapping_rings

![](http://jasonlong.github.io/geo_pattern/examples/overlapping_rings.png)

### plaid

![](http://jasonlong.github.io/geo_pattern/examples/plaid.png)

### triangles

![](http://jasonlong.github.io/geo_pattern/examples/triangles.png)

### squares

![](http://jasonlong.github.io/geo_pattern/examples/squares.png)

### nested_squares

![](http://jasonlong.github.io/geo_pattern/examples/nested_squares.png)

### mosaic_squares

![](http://jasonlong.github.io/geo_pattern/examples/mosaic_squares.png)

### concentric_circles

![](http://jasonlong.github.io/geo_pattern/examples/concentric_circles.png)

### diamonds

![](http://jasonlong.github.io/geo_pattern/examples/diamonds.png)

### tessellation

![](http://jasonlong.github.io/geo_pattern/examples/tessellation.png)


## Contributing

1. Fork it ( http://github.com/jasonlong/geo_pattern/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Ports

Brandon Mills is working on completing my original Javascript version:
https://github.com/btmills/geopatterns-js

Bryan Veloso is porting the library to Python:
https://github.com/bryanveloso/geopatterns

Anand Capur is porting the library to PHP:
https://github.com/redeyeventures/geopattern-php
