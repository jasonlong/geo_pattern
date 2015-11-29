require 'spec_helper'

RSpec.describe BackgroundGenerators::SolidGenerator do
  subject(:generator) { described_class.new(seed, preset) }

  let(:seed) { instance_double('GeoPattern::Seed') }
  let(:preset) { instance_double('GeoPattern::ColorPreset') }
  let(:pattern) { instance_double('GeoPattern::Pattern') }
  let(:background_metadata) { instance_double('GeoPattern::BackgroundMetadata') }

  let(:color) { '#aaaaaa' }
  let(:base_color) { '#bbbbbb' }
  let(:base_color_should_be_used) { true }

  before :each do
    allow(seed).to receive(:to_i).with(14, 3).and_return(2616)
    allow(seed).to receive(:to_i).with(17, 1).and_return(3)

    allow(preset).to receive(:mode?).with(:base_color).and_return(base_color_should_be_used)
    allow(preset).to receive(:color).and_return(color)
    allow(preset).to receive(:base_color).and_return(base_color)
  end

  it { is_expected.not_to be_nil }

  describe '#generate' do
    context 'when base color is given' do
      let(:generated_color) { %w(187 187 187) }

      before :each do
        expect(pattern).to receive(:background=).with(have_image_with_rgb_color(generated_color))
      end

      it { generator.generate(pattern) }
    end

    context 'when color is given' do
      let(:base_color_should_be_used) { false }
      let(:generated_color) { %w(170 170 170) }

      before :each do
        expect(pattern).to receive(:background=).with(have_image_with_rgb_color(generated_color))
      end

      it { generator.generate(pattern) }
    end

    it_behaves_like 'a named generator', :solid
  end
end
