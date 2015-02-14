RSpec.describe ColorGenerators::SimpleGenerator do
  subject(:generator) { described_class.new(color_string) }

  let(:color_string) { '#ff00ff' }

  it { is_expected.not_to be_nil }

  describe '#generate' do
    let(:color) { generator.generate }
    it { expect(color.to_svg).to eq 'rgb(255, 0, 255)' }
  end
end
