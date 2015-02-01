require 'spec_helper'

RSpec.describe ColorGenerators::BaseColorGenerator do
  subject(:generator) { described_class.new(color_string, seed) }

  let(:seed) { instance_double('GeoPattern::Seed') }
  let(:seed_value1) { 2616 }
  let(:seed_value2) { 2 }

  let(:color_string) { '#ff00ff' }

  it { is_expected.not_to be_nil }

  before :each do
    allow(seed).to receive(:to_i).with(14, 3).and_return(seed_value1)
    allow(seed).to receive(:to_i).with(17, 1).and_return(seed_value2)
  end

  describe '#generate' do
    let(:color) { generator.generate }

    context 'when sat offset is % 2 == 0' do
      it { expect(color.to_svg).to eq 'rgb(210, 255, 0)' }
    end

    context 'when sat offset is not % 2 == 0' do
      let(:seed_value2) { 3 }
      it { expect(color.to_svg).to eq 'rgb(207, 251, 4)' }
    end
  end
end
