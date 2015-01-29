require 'rspec/expectations'
require 'color'

RSpec::Matchers.define :has_image_with_rgb_color do |*expected|
  expected = format('rgb(%s, %s, %s)', *expected.flatten )

  match do |actual|
    actual.image.include? expected
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not be a multiple of #{expected}"
  end

  failure_message do |actual|
    "expected that #{actual} would not be a multiple of #{expected}"
  end
end

