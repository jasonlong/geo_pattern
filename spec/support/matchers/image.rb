require 'rspec/expectations'

RSpec::Matchers.define :have_image_with_rgb_color do |*expected|
  expected = format('rgb(%s, %s, %s)', *expected.flatten)

  match do |actual|
    actual.image.include? expected
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} includes color #{expected}"
  end

  failure_message do |actual|
    "expected that #{actual} not includes color #{expected}"
  end
end
