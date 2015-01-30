require 'spec_helper'

RSpec.describe PatternValidator do
  subject(:validator) { PatternValidator.new(store) }
  let(:store) { instance_double('GeoPattern::PatternStore') }
  let(:patterns) { [] }

  # Minimum valid object test
  it { expect(validator).not_to be_nil }

  describe '#validate' do
    context 'when valid pattern is validated' do
      before :each do
        allow(store).to receive(:known?).with('pattern1').and_return(true)
      end

      it { expect { validator.validate(%w(pattern1)) }.not_to raise_error }
    end

    context 'when invalid pattern is validated' do
      before :each do
        allow(store).to receive(:known?).with('pattern1').and_return(false)
      end

      it { expect { validator.validate(%w(pattern1)) }.to raise_error InvalidPatternError }
    end
  end
end
