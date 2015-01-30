require 'rspec/expectations'

RSpec::Matchers.define :have_name do |expected|
  match do |actual|
    actual.name? expected
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} does not nave name \"#{expected}\""
  end

  failure_message do |actual|
    "expected that #{actual} has name \"#{expected}\""
  end
end
