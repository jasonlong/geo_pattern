----

**NOTE: This is currently a WIP with an incomplete set of patterns.**

----

# GeoPattern

Generate beautiful tilng SVG patterns from a string.

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

To specify a base background color:

    pattern = GeoPattern.generate("Mastering Markdown", {:base_color => "#fc0"})

To use a specific [pattern generator](#available-patterns):

    pattern = GeoPattern.generate("Mastering Markdown", {:generator => "sine_waves"})

Get the SVG string:

    puts pattern.svg_string
    # => <svg xmlns="http://www.w3.org/2000/svg" ...

Get the Base64 encoded string:

    puts pattern.base64_string
    # => PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC...


## Available patterns

TODO: add images for each

* bricks
* overlapping_circles
* plus_signs
* xes
* sine_waves
* hexagons
* overlapping_rings
* plaid
* triangles
* triangles_rotated
* squares
* nested_squares
* mosaic_squares
* rings
* diamonds
* tessellation


## Contributing

1. Fork it ( http://github.com/jasonlong/geo_patterns/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
