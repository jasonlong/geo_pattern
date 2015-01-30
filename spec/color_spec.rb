require 'spec_helper'

RSpec.describe GeoPattern::Color do
  subject(:color) { described_class.new(color_string) }
  let(:color_string) { '#ff00ff' }
  let(:seed) { instance_double('GeoPattern::Seed') }

  describe '#to_svg' do
    context 'when unmodified' do
      it { expect(color.to_svg).to eq 'rgb(255, 0, 255)' }
    end

    context 'when modified based on seed' do
      let(:color_string) { '#ff00ff' }
      let(:seed_value1) { 2616 }
      let(:seed_value2) { 2 }

      before :each do
        allow(seed).to receive(:to_i).with(14, 3).and_return(seed_value1)
        allow(seed).to receive(:to_i).with(17, 1).and_return(seed_value2)
      end

      before :each do
        color.transform_with(seed)
      end

      context 'when sat offset is % 2 == 0' do
        it { expect(color.to_svg).to eq 'rgb(210, 255, 0)' }
      end

      context 'when sat offset is not % 2 == 0' do
        let(:seed_value2) { 3 }
        it { expect(color.to_svg).to eq 'rgb(207, 251, 4)' }
      end
    end
  end

  describe '#to_html' do
    it { expect(color.to_html).to eq color_string }
  end
end
