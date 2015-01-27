require 'spec_helper'

RSpec.describe Generators::BackgroundGenerator do
  subject(:generator) { Generators::BackgroundGenerator.new }
  let(:seed) { instance_double('GeoPattern::Seed' ) }

  before :each do
    allow(seed).to receive(:[]).with(14, 3).and_return('fff')
    allow(seed).to receive(:[]).with(17, 1).and_return('f')
  end

  it { expect(generator).not_to be_nil }

  describe '#generate' do
    context 'when base color is given' do

    end

    context 'when color is given' do

    end

  end
end
