require 'spec_helper'

RSpec.describe Helpers do
  describe '.underscore' do
    subject { described_class.underscore string }

    context 'when string is empty' do
      let(:string) { '' }

      it { is_expected.to eq '' }
    end

    context 'when string is in snakecase' do
      let(:string) { 'HelloWorld' }

      it { is_expected.to eq 'hello_world' }
    end

    context 'when string is in snakecase at some places' do
      let(:string) { 'helloWorld' }

      it { is_expected.to eq 'hello_world' }
    end
  end

  describe '.demodulize' do
    subject { described_class.demodulize string }

    context 'when constant' do
      before :each do
        stub_const('HelloWorld', Class.new)
      end

      let(:string) { HelloWorld }

      it { is_expected.to eq 'HelloWorld' }
    end

    context 'when string' do
      context 'is empty' do
        let(:string) { '' }

        it { is_expected.to eq '' }
      end

      context 'starts with ::' do
        let(:string) { '::Class' }

        it { is_expected.to eq 'Class' }
      end

      context 'has :: in betweend' do
        let(:string) { 'HelloWorld::Class' }

        it { is_expected.to eq 'Class' }
      end

      context 'when no namespaces is given' do
        let(:string) { 'HelloWorld' }

        it { is_expected.to eq 'HelloWorld' }
      end
    end
  end
end
