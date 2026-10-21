# frozen_string_literal: true

# Run against an installed gem with only its runtime dependencies available.
require "geo_pattern"
require "geo_pattern/geo_pattern_task"
require "tmpdir"

input = "Mastering Markdown"
fixtures = Dir.glob(File.expand_path("../fixtures/generated_patterns/*.svg", __dir__))
raise "No SVG fixtures found" if fixtures.empty?

fixtures.each do |fixture|
  name = File.basename(fixture, ".svg")
  options = case name
  when "diamonds_with_color"
    {patterns: :diamonds, color: "#00ff00"}
  when "diamonds_with_base_color"
    {patterns: :diamonds, base_color: "#00ff00"}
  else
    {patterns: name.to_sym}
  end

  expected = File.read(fixture)
  raise "SVG changed for #{name}" unless GeoPattern.generate(input, options).to_svg == expected

  encoded = GeoPattern.generate(input, options).to_base64
  raise "Invalid Base64 for #{name}" unless Base64.strict_decode64(encoded) == expected

  uri = GeoPattern.generate(input, options).to_data_uri
  raise "Invalid data URI for #{name}" unless uri == "url(data:image/svg+xml;base64,#{encoded});"
end

Dir.mktmpdir("geo-pattern-smoke") do |directory|
  output = File.join(directory, "patterns", "diamonds.svg")
  GeoPattern::GeoPatternTask.new(
    name: "smoke",
    description: "Verify the installed gem's Rake integration",
    data: {output => {input: input, patterns: [:diamonds]}}
  )
  Rake::Task["smoke"].invoke
  expected = File.read(File.expand_path("../fixtures/generated_patterns/diamonds.svg", __dir__))
  raise "Rake task generated unexpected SVG" unless File.read(output) == expected
end

puts "GeoPattern #{GeoPattern::VERSION}: #{fixtures.length} SVG fixtures, Base64, data URIs, and Rake integration passed."
