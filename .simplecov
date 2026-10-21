#!/usr/bin/env ruby
# frozen_string_literal: true

SimpleCov.configure do
  skip ["/features/", "/fixtures/", "/spec/", "/tmp", "/vendor"]

  generator_filter = %r{/background_generators/|/structure_generators/}
  group "lib" do |source_file|
    !source_file.filename.match?(generator_filter)
  end
  group "generators", generator_filter
end
