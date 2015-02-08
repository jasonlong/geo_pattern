require 'spec_helper'

RSpec.describe ColorPreset do
  subject(:preset) { ColorPreset.new(**options) }
  let(:options) do
    {
      base_color: '#0f0f0f'
    }
  end

  it { expect(preset).not_to be nil }

  describe '#base_color' do
    it { expect(preset.base_color).to eq '#0f0f0f' }
  end

  describe '#color' do
    context 'when set' do
      let(:options) do
        {
          base_color: '#0f0f0f',
          color: '#1f1f1f'
        }
      end

      it { expect(preset.color).to eq '#1f1f1f' }
    end
  end

  describe '#mode?' do
    context 'when nil' do
      let(:options) do
        {
          base_color: '#0f0f0f',
          color: nil
        }
      end

      it { expect(preset).to be_mode :base_color }
    end

    context 'when defined' do
      let(:options) do
        {
          base_color: '#0f0f0f',
          color: '#1f1f1f'
        }
      end

      it { expect(preset).to be_mode :color }
    end
  end
end
