#!/usr/bin/env ruby

class ExcludeRegexFilter < SimpleCov::Filter
  def matches?(source_file)
    source_file.filename !~ filter_argument
  end
end

class IncludeRegexFilter < SimpleCov::Filter
  def matches?(source_file)
    source_file.filename =~ filter_argument
  end
end

SimpleCov.start do
  add_filter "/features/"
  add_filter "/fixtures/"
  add_filter "/spec/"
  add_filter "/tmp"
  add_filter "/vendor"

  generator_filter = %r{/background_generators/|/structure_generators/}
  add_group "lib", ExcludeRegexFilter.new(generator_filter)
  add_group "generators", IncludeRegexFilter.new(generator_filter)
end
