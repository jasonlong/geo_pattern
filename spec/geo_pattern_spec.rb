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

      expect(pattern1.svg_string).to eq pattern2.svg_string
    end

    it 'sets background color with adjusting hue and saturation based on string' do
      html_base_color = '#fc0'
      rgb_base_color  = html_to_rgb_for_string(string, html_base_color)
      pattern         = GeoPattern.generate(string, base_color: html_base_color)

      expect(pattern.svg_string).to include(rgb_base_color)
    end

    it 'sets background color' do
      html_base_color = '#fc0'
      rgb_base_color  = html_to_rgb(html_base_color)
      pattern         = GeoPattern.generate(string, color: html_base_color)

      expect(pattern.svg_string).to include(rgb_base_color)
    end

    it 'uses the specified generator' do

      pattern1 = GeoPattern.generate(string, generator: GeoPattern::SineWavePattern)
      pattern2  = GeoPattern.generate(string)

      expect(pattern1.svg_string).not_to eq pattern2.svg_string
    end
  end
end
