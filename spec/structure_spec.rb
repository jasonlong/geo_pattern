RSpec.describe Structure do
  subject(:structure) { described_class.new(image: svg_image, preset: preset, generator: generator, name: name) }

  let(:svg_image) { instance_double('GeoPattern::SvgImage') }
  let(:svg_image_content) { fixtures_path('generated_patterns/sine_waves.svg').read.chomp }
  let(:preset) { instance_double('GeoPattern::PatternPreset') }
  let(:generator) { stub_const('GeoPattern::StructureGenerators::ChevronGenerator', Class.new) }
  let(:name) { :chevron }

  it { is_expected.not_to be_nil }

  describe '#name' do
  end

  describe '#name?' do
    context 'when name is not defined' do
      let(:name) { nil }
      it { expect { structure }.to raise_error ArgumentError, 'Argument name is missing' }
    end

    context 'when name is defined' do
      context 'when argument is not given' do
        it { is_expected.to be_name nil }
      end

      context 'when argument is the same as the defined one' do
        it { is_expected.to be_name name }
      end

      context 'when argument is different from the defined one' do
        it { is_expected.not_to be_name 'blub' }
      end
    end
  end

  describe '#generator' do
  end

  describe '#generator?' do
  end

  describe '#fill_color_dark' do
  end

  describe '#fill_color_dark?' do
  end

  describe '#fill_color_light' do
  end

  describe '#fill_color_light?' do
  end

  describe '#stroke_color' do
  end

  describe '#stroke_color?' do
  end

  describe '#stroke_opacity' do
  end

  describe '#stroke_opacity?' do
  end

  describe '#opacity_min' do
  end

  describe '#opacity_min?' do
  end

  describe '#opacity_max' do
  end

  describe '#opacity_max?' do
  end
end
