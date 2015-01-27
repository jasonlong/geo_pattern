# encoding: utf-8
require 'spec_helper'

RSpec.describe GeoPattern do
  let(:string) { 'Mastering Markdown' }

  context '.generate' do
    it 'generates a pattern for a string' do
      pattern = GeoPattern.generate(string)
      expect(pattern).not_to be_nil
    end

    it 'is always the same' do
      pattern1 = GeoPattern.generate(string)
      pattern2 = GeoPattern.generate(string)

      expect(pattern1.to_svg).to eq pattern2.to_svg
    end

    it 'sets background color with adjusting hue and saturation based on string' do
      string = 'Mastering Markdown'
      hash = Digest::SHA1.hexdigest string
      html_base_color = '#fc0'
      rgb_base_color  = PatternHelpers.html_to_rgb_for_string(hash, html_base_color)
      pattern         = GeoPattern.generate(string, base_color: html_base_color)

      expect(pattern.to_svg).to include(rgb_base_color)
    end

    it 'sets background color' do
      html_base_color = '#fc0'
      rgb_base_color  = PatternHelpers.html_to_rgb(html_base_color)
      pattern         = GeoPattern.generate(string, color: html_base_color)

      expect(pattern.to_svg).to include(rgb_base_color)
    end

    it 'uses the specified generator' do

      pattern1 = nil
      silence :stdout do
        pattern1 = GeoPattern.generate(string, generator: :sine_waves)
      end
      pattern2  = GeoPattern.generate(string)

      expect(pattern1.to_svg).not_to eq pattern2.to_svg
    end

    it 'uses the specified patterns only' do
      string   = 'Mastering Markdown'
      pattern = GeoPattern.generate(string, patterns: [:sine_waves, :xes])

      expect(pattern.to_svg).not_to be_nil
    end

    it 'makes no difference if you use generator or pattern' do
      string   = 'Mastering Markdown'

      pattern1 = nil
      silence :stdout do
        pattern1 = GeoPattern.generate(string, generator: :sine_waves)
      end
      pattern2 = GeoPattern.generate(string, patterns: :sine_waves)
      pattern3 = GeoPattern.generate(string, patterns: [:sine_waves])

      expect(pattern1.to_svg).to eq pattern2.to_svg
      expect(pattern1.to_svg).to eq pattern3.to_svg
    end

    it 'fails if an invalid generator was chosen' do
      string   = 'Mastering Markdown'

      expect {
        GeoPattern.generate(string, patterns: 'invalid_pattern')
      }.to raise_error
    end

    it 'fails if string and classes are mixed' do
      string   = 'Mastering Markdown'

      expect {
        GeoPattern.generate(string, patterns: [:sine_waves, 'invalid_pattern'])
      }.to raise_error
    end
  end
end
