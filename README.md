[![](https://img.shields.io/gem/v/geo_pattern.svg?style=flat)](http://rubygems.org/gems/geo_pattern)
[![](https://img.shields.io/travis/jasonlong/geo_pattern.svg?style=flat)](https://travis-ci.org/jasonlong/geo_pattern)
[![](https://img.shields.io/gem/dt/geo_pattern.svg?style=flat)](http://rubygems.org/gems/geo_pattern)

# GeoPattern

Generate beautiful tiling SVG patterns from a string. The string is converted
into a SHA and a color and pattern are determined based on the values in the
hash. The color is determined by shifting the hue and saturation from a default
(or passed in) base color. One of 16 patterns is used (or you can specify one)
and the sizing of the pattern elements is also determined by the hash values.

You can use the generated pattern as the `background-image` for a container.
Using the `base64` representation of the pattern still results in SVG
rendering, so it looks great on retina displays.

See the [GitHub Guides](https://guides.github.com/) site and the [Explore section
of GitHub](https://github.com/explore) are examples of this library in action.
Brandon Mills has put together an awesome [live preview
page](http://btmills.github.io/geopattern/geopattern.html) that's built on his
Javascript port.

## Installation

**Note:** as of version `1.4.0`, Ruby version 2 or greater is required.

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
pattern = GeoPattern.generate('Mastering Markdown', patterns: :sine_waves)
```

To use a subset of the [available patterns](#available-patterns):

```ruby
pattern = GeoPattern.generate('Mastering Markdown', patterns: [:sine_waves, :xes])
```

Get the SVG string:

```ruby
puts pattern.to_svg
# => <svg xmlns="http://www.w3.org/2000/svg" ...
```

Get the Base64 encoded string:

```ruby
puts pattern.to_base64
# => PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC...
```

You can then use this string to set the background:

```html
<div style="background-image: <%= pattern.to_data_uri %>"></div>
```

## Available patterns

*Note: As of version `1.3.0`, string references (e.g. `overlapping_circles`)
are deprecated in favor of symbol references (e.g. `:overlapping_circles`).*

### :chevrons

![](http://jasonlong.github.io/geo_pattern/examples/chevrons.png)


### :octagons

![](http://jasonlong.github.io/geo_pattern/examples/octogons.png)

### :overlapping_circles

![](http://jasonlong.github.io/geo_pattern/examples/overlapping_circles.png)

### :plus_signs

![](http://jasonlong.github.io/geo_pattern/examples/plus_signs.png)

### :xes

![](http://jasonlong.github.io/geo_pattern/examples/xes.png)

### :sine_waves

![](http://jasonlong.github.io/geo_pattern/examples/sine_waves.png)

### :hexagons

![](http://jasonlong.github.io/geo_pattern/examples/hexagons.png)

### :overlapping_rings

![](http://jasonlong.github.io/geo_pattern/examples/overlapping_rings.png)

### :plaid

![](http://jasonlong.github.io/geo_pattern/examples/plaid.png)

### :triangles

![](http://jasonlong.github.io/geo_pattern/examples/triangles.png)

### :squares

![](http://jasonlong.github.io/geo_pattern/examples/squares.png)

### :nested_squares

![](http://jasonlong.github.io/geo_pattern/examples/nested_squares.png)

### :mosaic_squares

![](http://jasonlong.github.io/geo_pattern/examples/mosaic_squares.png)

### :concentric_circles

![](http://jasonlong.github.io/geo_pattern/examples/concentric_circles.png)

### :diamonds

![](http://jasonlong.github.io/geo_pattern/examples/diamonds.png)

### :tessellation

![](http://jasonlong.github.io/geo_pattern/examples/tessellation.png)

### :chevrons

![](http://jasonlong.github.io/geo_pattern/examples/chevrons.png)


## Inspection of pattern

If you want to get some more information about a pattern, please use the
following methods.

```ruby
pattern = GeoPattern.generate('Mastering Markdown', patterns: [:sine_waves, :xes])

# The color of the background in html notation
pattern.background.color.to_html

# The color of the background in svg notation
pattern.background.color.to_svg


# The input colors
pattern.background.preset.color
pattern.background.preset.base_color

# The generator
pattern.background.generator
```

To get more information about the structure of the pattern, please use the following methods:

```ruby
pattern = GeoPattern.generate('Mastering Markdown', patterns: [:sine_waves, :xes])

# The name of the structure
pattern.structure.name

# The generator of the structure
pattern.structure.generator
```

## Rake Support

```ruby
string = 'Mastering markdown'

require 'geo_pattern/geo_pattern_task'

GeoPattern::GeoPatternTask.new(
  name: 'generate',
  description: 'Generate patterns to make them available as fixtures',
  data: {
    'fixtures/generated_patterns/diamonds_with_color.svg'      => { input: string, patterns: [:diamonds], color: '#00ff00' },
    'fixtures/generated_patterns/diamonds_with_base_color.svg' => { input: string, patterns: [:diamonds], base_color: '#00ff00' }
  }
)
```

## Developing

### Generate Fixtures

```ruby
rake fixtures:generate
```

### Run tests

```ruby
rake test
```

## Contributing

1. Fork it ( https://github.com/jasonlong/geo_pattern/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Development

Prefix rspec-commandline with `RSPEC_PROFILE=1` to output the ten slowest
examples of the test suite.

```bash
RSPEC_PROFILE=1 bundle exec rspec
```

## Ports & related projects

JavaScript port by Brandon Mills:
https://github.com/btmills/geopattern

Python port by Bryan Veloso:
https://github.com/bryanveloso/geopatterns

Elixir port by Anne Johnson:
https://github.com/annejohnson/geo_pattern

PHP port by Anand Capur:
https://github.com/redeyeventures/geopattern-php

Go port by Pravendra Singh:
https://github.com/pravj/geopattern

CoffeeScript port by Aleks (muchweb):
https://github.com/muchweb/geo-pattern-coffee

Cocoa port by Matt Faluotico:
https://github.com/mattfxyz/GeoPattern-Cocoa

Middleman extension by @maxmeyer:
https://github.com/fedux-org/middleman-geo_pattern
