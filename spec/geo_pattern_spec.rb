# encoding: utf-8
require 'spec_helper'

RSpec.describe GeoPattern do
  context '.generate' do
    it 'generates a pattern for a string' do
      pattern = GeoPattern.generate('Mastering Markdown')
      expect(pattern).not_to be_nil
    end

    it 'is always the same' do
      pattern1 = GeoPattern.generate('Mastering Markdown')
      pattern2 = GeoPattern.generate('Mastering Markdown')

      expect(pattern1.svg_string).to eq pattern2.svg_string
    end

    it 'sets background color with adjusting hue and saturation based on string' do
      string = 'Mastering Markdown'
      html_base_color = '#fc0'
      rgb_base_color  = html_to_rgb_for_string(string, html_base_color)
      pattern         = GeoPattern.generate(string, base_color: html_base_color)

      expect(pattern.svg_string).to include(rgb_base_color)
    end

    it 'sets background color' do
      string = 'Mastering Markdown'
      html_base_color = '#fc0'
      rgb_base_color  = html_to_rgb(html_base_color)
      pattern         = GeoPattern.generate(string, color: html_base_color)

      expect(pattern.svg_string).to include(rgb_base_color)
    end
  end
end
