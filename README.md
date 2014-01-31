# GeoPattern

Generate beautiful SVG patterns from a string.

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

Get the SVG string:

    puts pattern.svg_string
    # => <svg xmlns="http://www.w3.org/2000/svg" ...

Get the Base64 encoded string:

    puts pattern.base64_string
    # => PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC...


## Contributing

1. Fork it ( http://github.com/jasonlong/geo_patterns/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
