require 'spec_helper'

RSpec.describe PatternSieve do
  subject(:sieve) { PatternSieve.new(requested_patterns, seed, store) }

  before :each do
    stub_const('Pattern1', Class.new)
    stub_const('Pattern2', Class.new)
  end

  let(:store) { instance_double('GeoPattern::PatternStore') }
  let(:available_patterns) { [Pattern1, Pattern2] }
  let(:requested_patterns) { [:pattern1, :pattern2] }
  let(:seed) { instance_double('GeoPattern::Seed') }

  before :each do
    allow(seed).to receive(:to_i).with(20, 1).and_return(1)
    allow(store).to receive(:[])
  end

  # Minimum valid object test
  it { expect(sieve).not_to be_nil }

  describe '#fetch' do
    context 'when requested_patterns is empty' do
      let(:requested_patterns) { nil }

      before :each do
        expect(store).to receive(:all).and_return(available_patterns)
        expect(store).not_to receive(:[])
      end

      it { expect(sieve.fetch).to eq Pattern2 }
    end

    context 'when a valid pattern is requested' do
      let(:requested_patterns) { [:pattern1] }

      before :each do
        expect(store).to receive(:[]).with(:pattern1).and_return(Pattern1)
      end

      it { expect(sieve.fetch).to eq Pattern1 }
    end

    context 'when an invalid pattern is requested' do
      let(:requested_patterns) { [:patternX] }

      before :each do
        allow(store).to receive(:[]).with(:patternX).and_return(nil)
      end

      it { expect(sieve.fetch).to be nil }
    end

    context 'when a requested pattern is nil' do
      let(:requested_patterns) { [:pattern1, nil, :pattern2] }

      before :each do
        expect(store).not_to receive(:[]).with(nil)
      end

      it { sieve.fetch }
    end
  end
end
