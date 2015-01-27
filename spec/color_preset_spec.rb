require 'spec_helper'

RSpec.describe ColorPreset do
  subject(:preset) { ColorPreset.new(options) }
  let(:options) { 
    {
      base_color: '#0f0f0f'
    }
  }

  it { expect(preset).not_to be nil }

  describe '#base_color' do
    it { expect(preset.base_color).to eq '#0f0f0f' }
  end

  describe '#color' do
    context 'when set' do
      let(:options) { 
        {
          base_color: '#0f0f0f',
          color: '#1f1f1f'
        }
      }

      it { expect(preset.color).to eq '#1f1f1f' }
    end
  end

  describe '#color?' do
    context 'when nil' do
      let(:options) { 
        {
          base_color: '#0f0f0f',
          color: nil
        }
      }

      it { expect(preset).not_to be_color }
    end

    context 'when defined' do
      let(:options) { 
        {
          base_color: '#0f0f0f',
          color: '#1f1f1f'
        }
      }

      it { expect(preset).to be_color }
    end
  end
end
