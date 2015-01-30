[![](http://img.shields.io/gem/v/geo_pattern.svg?style=flat)](http://rubygems.org/gems/geo_pattern)
[![](https://img.shields.io/travis/jasonlong/geo_pattern.svg?style=flat)](https://travis-ci.org/jasonlong/geo_pattern)
[![](http://img.shields.io/gem/dt/geo_pattern.svg?style=flat)](http://rubygems.org/gems/geo_pattern)

# GeoPattern

Generate beautiful tiling SVG patterns from a string. The string is converted into a SHA and a color and pattern are determined based on the values in the hash. The color is determined by shifting the hue and saturation from a default (or passed in) base color. One of 16 patterns is used (or you can specify one) and the sizing of the pattern elements is also determined by the hash values.

You can use the generated pattern as the `background-image` for a container. Using the `base64` representation of the pattern still results in SVG rendering, so it looks great on retina displays.

See the [GitHub Guides](http://guides.github.com) site and the [Explore section of GitHub](https://github.com/explore) are examples of this library in action. Brandon Mills has put together an awesome [live preview page](http://btmills.github.io/geopattern/geopattern.html) that's built on his Javascript port.

## Installation

Add this line to your application's Gemfile:

    gem 'geo_pattern'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install geo_pattern

## Usage

Make a new pattern:

```ruby
pattern = GeoPattern.generate('Mastering Markdown')
```

To specify a base background color (with a hue and saturation that adjusts depending on the string):

```ruby
pattern = GeoPattern.generate('Mastering Markdown', base_color: '#fc0')
```

To use a specific background color (w/o any hue or saturation adjustments):

```ruby
pattern = GeoPattern.generate('Mastering Markdown', color: '#fc0')
```

To use a specific [pattern generator](#available-patterns):

```ruby
pattern = GeoPattern.generate('Mastering Markdown', patterns: GeoPattern::SineWavePattern)
```

To use a subset of the [available patterns](#available-patterns):

```ruby
pattern = GeoPattern.generate('Mastering Markdown', patterns: [GeoPattern::SineWavePattern, GeoPattern::XesPattern])
```

Get the SVG string:

```ruby
puts pattern.svg_string
# => <svg xmlns="http://www.w3.org/2000/svg" ...
```

Get the Base64 encoded string:

```ruby
puts pattern.base64_string
# => PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC...
```

You can then use this string to set the background:

```html
<div style="background-image: <%= pattern.uri_image %>"></div>
```

## Available patterns

*Note: As of version `1.3.0`, string references (e.g. `overlapping_circles`) are deprecated in favor of class references (e.g. `GeoPattern::OverlappingCirclesPattern`).*

### GeoPattern::OctagonPattern

![](http://jasonlong.github.io/geo_pattern/examples/octogons.png)

### GeoPattern::OverlappingCirclesPattern

![](http://jasonlong.github.io/geo_pattern/examples/overlapping_circles.png)

### GeoPattern::PlusSignPattern

![](http://jasonlong.github.io/geo_pattern/examples/plus_signs.png)

### GeoPattern::XesPattern

![](http://jasonlong.github.io/geo_pattern/examples/xes.png)

### GeoPattern::SineWavePattern

![](http://jasonlong.github.io/geo_pattern/examples/sine_waves.png)

### GeoPattern::HexagonPattern

![](http://jasonlong.github.io/geo_pattern/examples/hexagons.png)

### GeoPattern::OverlappingCirclesPattern

![](http://jasonlong.github.io/geo_pattern/examples/overlapping_rings.png)

### GeoPattern::PlaidPattern

![](http://jasonlong.github.io/geo_pattern/examples/plaid.png)

### GeoPattern::TrianglePattern

![](http://jasonlong.github.io/geo_pattern/examples/triangles.png)

### GeoPattern::SquarePattern

![](http://jasonlong.github.io/geo_pattern/examples/squares.png)

### GeoPattern::NestedSquaresPattern

![](http://jasonlong.github.io/geo_pattern/examples/nested_squares.png)

### GeoPattern::MosaicSquaresPattern

![](http://jasonlong.github.io/geo_pattern/examples/mosaic_squares.png)

### GeoPattern::ConcentricCirclesPattern

![](http://jasonlong.github.io/geo_pattern/examples/concentric_circles.png)

### GeoPattern::DiamondPattern

![](http://jasonlong.github.io/geo_pattern/examples/diamonds.png)

### GeoPattern::TessellationPattern

![](http://jasonlong.github.io/geo_pattern/examples/tessellation.png)


## Contributing

1. Fork it ( http://github.com/jasonlong/geo_pattern/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Ports

JavaScript port by Brandon Mills:
https://github.com/btmills/geopatterns-js

Python port by Bryan Veloso:
https://github.com/bryanveloso/geopatterns

PHP port by Anand Capur:
https://github.com/redeyeventures/geopattern-php

Go port by Pravendra Singh:
https://github.com/pravj/geo_pattern

CoffeeScript port by Aleks (muchweb):
https://github.com/muchweb/geo-pattern-coffee
