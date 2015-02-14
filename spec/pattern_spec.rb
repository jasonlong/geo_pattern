require 'spec_helper'

RSpec.describe Pattern do
  subject(:pattern) { Pattern.new(svg_image) }

  let(:svg_image) { instance_double('GeoPattern::SvgImage') }
  let(:svg_image_content) { fixtures_path('generated_patterns/sine_waves.svg').read.chomp }
  let(:background) { instance_double('GeoPattern::Background') }
  let(:background_image) { instance_double('GeoPattern::SvgImage') }
  let(:background_body) { %(<rect x="0" y="0" width="100%" height="100%" fill="rgb(121, 131, 76)"  />) }
  let(:structure) { instance_double('GeoPattern::Structure') }
  let(:structure_image) { instance_double('GeoPattern::SvgImage') }
  let(:structure_body) { %(<path d=\"M0 53 C 28.0 0, 52.0 0, 80 53 S 132.0 106, 160 53 S 212.0 0, 240.0, 53\" fill=\"none\" stroke=\"#222\" style=\"opacity:0.046;stroke-width:6px;\" transform=\"translate(-40, -79.5)\"  />) }

  it { expect(pattern).not_to be_nil }

  before :each do
    allow(svg_image).to receive(:to_s).and_return svg_image_content
    allow(svg_image).to receive(:height=).and_return 100
    allow(svg_image).to receive(:width=).and_return 100

    allow(background).to receive(:image).and_return background_image

    allow(structure).to receive(:image).and_return structure_image
  end

  describe '#to_s' do
    before :each do
      allow(svg_image).to receive(:to_s).and_return(svg_image_content)
    end

    it { expect(pattern.to_s).to eq svg_image_content }
  end

  describe '#to_base64' do
    before :each do
      allow(svg_image).to receive(:to_s).and_return(svg_image_content)
    end

    it { expect(pattern.to_base64).to include 'PHN2ZyB4bWxuc' }
  end

  describe '#to_data_uri' do
    before :each do
      allow(svg_image).to receive(:to_s).and_return(svg_image_content)
    end

    it { expect(pattern.to_data_uri).to include 'PHN2ZyB4bWxuc' }
  end

  describe '#generate_me' do
    context 'when a background is added' do
      let(:generator) { instance_double('GeoPattern::BackgroundGenerator') }

      before :each do
        expect(generator).to receive(:generate).with(pattern)
      end

      it do
        pattern.generate_me(generator)
      end
    end
  end

  describe '#include?' do
    it do
      expect(svg_image).to receive(:include?)

      pattern.include? ''
    end
  end
end
