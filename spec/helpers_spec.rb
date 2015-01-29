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
end
