require 'spec_helper'

RSpec.describe Generators::BackgroundGenerator do
  subject(:generator) { Generators::BackgroundGenerator.new(seed, color_preset) }
  let(:seed) { instance_double('GeoPattern::Seed' ) }
  let(:color_preset) { instance_double('GeoPattern::ColorPreset' ) }
  let(:base_color) { '#bbbbbb' }
  let(:color) { '#aaaaaa' }
  let(:color_should_be_used) { false }

  before :each do
    allow(seed).to receive(:to_i).with(14, 3).and_return(2616)
    allow(seed).to receive(:to_i).with(17, 1).and_return(3)

    allow(color_preset).to receive(:color?).and_return(color_should_be_used)
    allow(color_preset).to receive(:color).and_return(color)
    allow(color_preset).to receive(:base_color).and_return(base_color)
  end

  it { expect(generator).not_to be_nil }

  describe '#generate' do
    context 'when base color is given' do
      it { expect(generator.generate).to eq 'adf' }
    end

    context 'when color is given' do
      let(:color_should_be_used) { true }
      it { expect(generator.generate).to eq 'adf' }
    end
  end
end
