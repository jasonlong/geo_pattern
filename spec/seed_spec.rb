require 'spec_helper'

RSpec.describe Seed do
  subject(:seed) { Seed.new(input) }
  let(:input) { 'string' }

  it { expect(seed).not_to be_nil }

  describe '#[]' do
    context 'when use an integer' do
      it { expect(seed[1]).to be_kind_of String }
    end
  end
end
