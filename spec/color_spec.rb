require 'spec_helper'

RSpec.describe GeoPattern::Color do
  subject(:color) { described_class.new(color_string) }
  let(:color_string) { '#ff00ff' }
  let(:seed) { instance_double('GeoPattern::Seed') }

  describe '#to_svg' do
    it { expect(color.to_svg).to eq 'rgb(255, 0, 255)' }
  end

  describe '#to_html' do
    it { expect(color.to_html).to eq color_string }
  end
end
