require 'spec_helper'

RSpec.describe PatternSieve do
  subject(:sieve) { PatternSieve.new(store) }

  let(:store) { instance_double('GeoPattern::PatternStore') }
  let(:available_patterns) { %w(pattern1 pattern2) }
  let(:filter) { [] }

  # Minimum valid object test
  it { expect(sieve).not_to be_nil }

  describe '#fetch' do
    context 'when requested patterns is empty' do
      before :each do
        expect(store).to receive(:all).and_return(available_patterns)
      end

      it { expect(sieve.fetch(filter)).to eq %w(pattern1 pattern2) }
    end

    context 'when a valid pattern is requested' do
      let(:filter) { %w(pattern1) }

      before :each do
        expect(store).to receive(:[]).and_return('pattern1')
      end

      it { expect(sieve.fetch(filter)).to eq %w(pattern1) }
    end

    context 'when an invalid pattern is requested' do
      let(:filter) { %w(pattern1 pattern2 pattern3) }

      before :each do
        allow(store).to receive(:[]).with('pattern1').and_return('pattern1')
        allow(store).to receive(:[]).with('pattern2').and_return('pattern2')
        allow(store).to receive(:[]).with('pattern3').and_return(nil)
      end

      it { expect(sieve.fetch(filter)).to eq %w(pattern1 pattern2) }
    end

    context 'when a requested pattern is nil' do
      let(:filter) { ['pattern1', nil, 'pattern2'] }

      before :each do
        expect(store).not_to receive(:[]).with(nil)
      end

      it { sieve.fetch(filter) }
    end
  end
end
