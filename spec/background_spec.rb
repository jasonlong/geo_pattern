require 'spec_helper'

RSpec.describe Background do

  subject { described_class.new(options) }

  let(:preset) { instance_double('GeoPattern::PatternPreset') }

  let(:options) { 
    {
      preset: preset,

    }
  }

  describe '#base_color' do
  end

  describe '#base_color?' do
  end

  describe '#color' do
  end

  describe '#color?' do
  end

  describe '#generator' do
  end

  describe '#generator?' do
  end

  describe '#type' do
  end

  describe '#type?' do
  end
end
