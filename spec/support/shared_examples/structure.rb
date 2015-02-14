RSpec.shared_examples 'a metadata argument' do |argument|
  describe "##{argument}" do
    it { expect(metadata.public_send(argument)).to eq public_send(argument) }
  end

  describe "##{argument}?" do
    context "when #{argument} is not defined" do
      let(argument) { nil }
      it { expect { metadata }.to raise_error ArgumentError, "Argument #{argument} is missing" }
    end

    context "when #{argument} is defined" do
      context 'when argument is not given' do
        it { is_expected.to public_send(:"be_#{argument}", nil) }
      end

      context 'when argument is the same as the defined one' do
        it { is_expected.to public_send(:"be_#{argument}", public_send(argument)) }
      end

      context 'when argument is different from the defined one' do
        it { is_expected.not_to public_send(:"be_#{argument}", 'blub') }
      end
    end
  end
end

RSpec.shared_examples 'a forwarded metadata argument' do |argument|
  describe "##{argument}" do
    it { expect(metadata.public_send(argument)).to eq public_send(argument) }
  end

  describe "##{argument}?" do
    context "when #{argument} is defined" do
      context 'when argument is not given' do
        it { is_expected.to public_send(:"be_#{argument}", nil) }
      end

      context 'when argument is the same as the defined one' do
        it { is_expected.to public_send(:"be_#{argument}", public_send(argument)) }
      end

      context 'when argument is different from the defined one' do
        it { is_expected.not_to public_send(:"be_#{argument}", 'blub') }
      end
    end
  end
end
