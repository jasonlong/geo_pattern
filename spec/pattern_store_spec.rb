require 'spec_helper'

RSpec.describe PatternStore do
  subject(:pattern_store) { PatternStore.new }

  it { expect(pattern_store).not_to be_nil }

  describe '#[]' do
    context 'when a known pattern is requested' do
      context 'as string' do
        let(:pattern_name) { 'xes' }
        it_behaves_like 'a known pattern name'
      end

      context 'as klass' do
        let(:pattern_name) { XesPattern }
        it_behaves_like 'a known pattern name'
      end

      context 'as symbol' do
        let(:pattern_name) { :xes }
        it_behaves_like 'a known pattern name'
      end
    end

    context 'when an unknown pattern is requested' do
      context 'as string' do
        let(:pattern_name) { 'unknown' }
        it_behaves_like 'an unknown pattern name'
      end

      context 'as klass' do
        let(:pattern_name) do
          stub_const('UnknownPattern', Class.new)
          UnknownPattern
        end

        it_behaves_like 'an unknown pattern name'
      end

      context 'as symbol' do
        let(:pattern_name) { :unknown }
        it_behaves_like 'an unknown pattern name'
      end
    end
  end
end
