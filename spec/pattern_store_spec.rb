require 'spec_helper'

RSpec.describe PatternStore do
  subject(:pattern_store) { PatternStore.new(hash_store) }
  let(:hash_store) { instance_double('GeoPattern::HashStore') }

  it { expect(pattern_store).not_to be_nil }

  class Pattern1; end

  describe '#[]' do
    context 'when real data is used' do
      subject(:pattern_store) { PatternStore.new }
      context 'when a known pattern is requested' do
        context 'as string' do
          let(:pattern_name) { 'xes' }
          it_behaves_like 'a valid pattern name'
        end

        context 'as klass' do
          let(:pattern_name) { StructureGenerators::XesGenerator }
          it_behaves_like 'a valid pattern name'
        end

        context 'as symbol' do
          let(:pattern_name) { :xes }
          it_behaves_like 'a valid pattern name'
        end
      end
    end

    context 'when a known pattern is requested' do
      context 'as string' do
        before :each do
          allow(hash_store).to receive(:[]).with('pattern1').and_return(Pattern1)
        end

        it do
          silence :stderr do
            expect(pattern_store['pattern1']).to eq Pattern1
          end
        end
      end

      context 'as symbol' do
        before :each do
          allow(hash_store).to receive(:[]).with(:pattern1).and_return(Pattern1)
        end

        it { expect(pattern_store[:pattern1]).to eq Pattern1 }
      end

      context 'as klass' do
        before(:each) do
          allow(hash_store).to receive(:value?).with(Pattern1).and_return(true)
        end

        it { silence(:stderr) { expect(pattern_store[Pattern1]).to eq Pattern1 } }
      end
    end

    context 'when a unknown pattern is requested' do
      before :each do
        allow(hash_store).to receive(:[]).and_return(nil)
        allow(hash_store).to receive(:value?).and_return(nil)
      end

      context 'as string' do
        it do
          silence :stderr do
            expect(pattern_store['pattern1']).to be_nil
          end
        end
      end

      context 'as symbol' do
        it { expect(pattern_store[:pattern1]).to be_nil }
      end

      context 'as klass' do
        silence :stderr do
          it { expect(pattern_store[Pattern1]).to be_nil }
        end
      end
    end
  end

  describe '#all' do
    before :each do
      allow(hash_store).to receive(:values).and_return([Pattern1])
    end

    it { expect(pattern_store.all).to eq [Pattern1] }
  end

  describe '#known?' do
    context 'when a known name is checked' do
      context 'when a string pattern name is passed in' do
        let(:pattern_name) { 'pattern' }

        before :each do
          allow(hash_store).to receive(:key?).with(pattern_name).and_return(true)
        end

        it { expect(pattern_store).to be_known pattern_name }
      end

      context 'when a symbol pattern name is passed in' do
        let(:pattern_name) { :pattern }

        before :each do
          allow(hash_store).to receive(:key?).with(pattern_name).and_return(true)
        end

        it { expect(pattern_store).to be_known pattern_name }
      end

      context 'when a class name is passed in' do
        let(:pattern_name) { Pattern1 }

        before :each do
          allow(hash_store).to receive(:value?).with(pattern_name).and_return(true)
        end

        it { expect(pattern_store).to be_known pattern_name }
      end
    end
  end
end
