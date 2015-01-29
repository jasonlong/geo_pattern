require 'spec_helper'

RSpec.describe BackgroundGenerators::SolidGenerator do
  subject(:generator) { described_class.new(seed, color_preset) }

  let(:seed) { instance_double('GeoPattern::Seed' ) }
  let(:color_preset) { instance_double('GeoPattern::ColorPreset' ) }
  let(:pattern) { instance_double('GeoPattern::Pattern' ) }
  let(:background_metadata) { instance_double('GeoPattern::BackgroundMetadata' ) }

  let(:color) { '#aaaaaa' }
  let(:base_color) { '#bbbbbb' }
  let(:color_should_be_used) { false }
  let(:svg) {  }

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
      let(:generated_color) { %w(187 187 187) }

      before :each do
        expect(pattern).to receive(:background=).with(has_image_with_rgb_color(generated_color))
      end

      it { expect(generator.generate(pattern)) }
    end

    context 'when color is given' do
      let(:color_should_be_used) { true }
      let(:generated_color) { %w(170 170 170) }

      before :each do
        expect(pattern).to receive(:background=).with(has_image_with_rgb_color(generated_color))
      end

      it { expect(generator.generate(pattern)) }
    end
  end
end
