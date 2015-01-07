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
  end
end
