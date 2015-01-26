require 'spec_helper'

RSpec.describe Seed do
  subject(:seed) { Seed.new(input) }
  let(:input) { 'string' }

  it { expect(seed).not_to be_nil }

  describe '#to_s' do
    context 'when input is a string' do
      it { expect(seed.to_s).to be_kind_of String }
    end

    context 'when input is a integer' do
      let(:input) { 1 }
      it { expect(seed.to_s).to be_kind_of String }
    end
  end

  describe '#[]' do
    context 'when use an integer' do
      it { expect(seed[1]).to be_kind_of String }
    end
  end
end
