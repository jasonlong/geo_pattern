RSpec.shared_examples 'a structure generator' do |name|
  subject {  described_class.new(seed, preset, svg_image) }

  let(:seed) { instance_double('GeoPattern::Seed') }
  let(:preset) { instance_double('GeoPattern::PatternPreset') }
  let(:svg_image) { SvgImage.new }
  let(:pattern) { instance_double('GeoPattern::Pattern') }

  let(:name) { name }

  let(:fill_color_dark) { '#222' }
  let(:fill_color_light) { '#ddd' }
  let(:stroke_color) { '#000' }
  let(:stroke_opacity) { 0.02 }
  let(:opacity_min) { 0.02 }
  let(:opacity_max) { 0.15 }

  before :each do
    allow(preset).to receive(:fill_color_dark).and_return(fill_color_dark)
    allow(preset).to receive(:fill_color_light).and_return(fill_color_light)
    allow(preset).to receive(:stroke_color).and_return(stroke_color)
    allow(preset).to receive(:stroke_opacity).and_return(stroke_opacity)
    allow(preset).to receive(:opacity_min).and_return(opacity_min)
    allow(preset).to receive(:opacity_max).and_return(opacity_max)

    allow(seed).to receive(:to_i).and_return(1)
  end

  it { is_expected.not_to be_nil }
  it { is_expected.to respond_to(:generate) }

  it do
    expect(pattern).to receive(:structure=).with(kind_of(Structure))
    expect(pattern).to receive(:height=).with(kind_of(Numeric))
    expect(pattern).to receive(:width=).with(kind_of(Numeric))

    subject.generate(pattern)
  end

  it_behaves_like 'a named generator', name
end

RSpec.shared_examples 'a named generator' do |name|
  it { is_expected.to have_name name }
  it { is_expected.to have_name name.to_s }
end
