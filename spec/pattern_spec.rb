require 'spec_helper'

RSpec.describe Pattern do
  subject(:pattern) { Pattern.new(svg_image) }
  let(:svg_image) { instance_double('GeoPattern::SvgImage') }

  it { expect(pattern).not_to be_nil }

  describe '#to_s' do
    before :each do
      allow(svg_image).to receive(:to_s).and_return
    end
    it { expect(pattern.to_s).to be_kind_of String }
    it { expect(pattern.to_s).to include 'svg' }
  end
end
