require 'spec_helper'

RSpec.describe PatternPreset do
  subject(:preset) { PatternPreset.new(options) }
  let(:options) do
    {
      fill_color_dark: '#222',
      fill_color_light: '#ddd',
      stroke_color: '#000',
      stroke_opacity: 0.02,
      opacity_min: 0.02,
      opacity_max: 0.15
    }
  end

  it { expect(preset).not_to be nil }

  describe '#fill_color_dark' do
    it { expect(preset.fill_color_dark).to eq '#222' }
  end

  describe '#fill_color_light' do
    it { expect(preset.fill_color_light).to eq '#ddd' }
  end

  describe '#stroke_color' do
    it { expect(preset.stroke_color).to eq '#000' }
  end

  describe '#stroke_opacity' do
    it { expect(preset.stroke_opacity).to eq 0.02 }
  end

  describe '#opacity_min' do
    it { expect(preset.opacity_min).to eq 0.02 }
  end

  describe '#opacity_max' do
    it { expect(preset.opacity_max).to eq 0.15 }
  end
end
