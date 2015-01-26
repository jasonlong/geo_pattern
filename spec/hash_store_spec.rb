require 'spec_helper'

RSpec.describe HashStore do
  subject(:store) { HashStore.new({}) }

  it { expect(store).not_to be_nil }

  describe '#key?' do
    context 'when store contains symbol keys' do
      subject(:store) { HashStore.new(key: 'value') }

      context 'and symbol key is checked' do
        it { expect(store).to be_key :key }
      end

      context 'and string key is checked' do
        it { expect(store).to be_key 'key' }
      end
    end

    context 'when store contains string key' do
      subject(:store) { HashStore.new('key' => 'value') }

      context 'and symbol key is checked' do
        it { expect(store).to be_key :key }
      end

      context 'and string key is checked' do
        it { expect(store).to be_key 'key' }
      end
    end

    context 'when store does not contain key' do
      it { expect(store).not_to be_key 'key' }
      it { expect(store).not_to be_key :key }
    end
  end

  describe '#value?' do
    subject(:store) { HashStore.new('key' => 'value') }

    context 'when store contains value' do
      it { expect(store).to be_value 'value' }
    end

    context 'when store does not contain value' do
      it { expect(store).not_to be_value 'non existing value' }
    end
  end

  describe '#all' do
    subject(:store) { HashStore.new('key' => 'value') }
    let(:values) { %w(value) }

    it { expect(store.values).to eq values }
  end

  describe '#[]' do
    context 'when an existing key is requested' do
      subject(:store) { HashStore.new('key' => 'value') }
      let(:key) { 'key' }
      let(:value) { 'value' }

      context 'when key is string' do
        it { expect(store[key]).to eq value }
      end

      context 'when key is symbol' do
        let(:key) { :key }
        it { expect(store[key]).to eq value }
      end
    end

    context 'when a not-existing key is requested' do
      let(:key) { 'key' }
      let(:value) { nil }

      it { expect(store[key]).to eq value }
    end
  end
end
