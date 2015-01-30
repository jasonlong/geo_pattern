require 'spec_helper'

RSpec.describe Background do
  subject(:metadata) { described_class.new(image: svg_image, preset: preset, generator: generator, color: color) }

  let(:svg_image) { instance_double('GeoPattern::SvgImage') }
  let(:svg_image_content) { fixtures_path('generated_patterns/sine_waves.svg').read.chomp }
  let(:preset) { instance_double('GeoPattern::ColorPreset') }
  let(:generator) { stub_const('GeoPattern::BackgroundGenerators::SolidGenerator', Class.new) }

  let(:color) { '#aaaaaa' }
  let(:base_color) { '#bbbbbb' }

  it { is_expected.not_to be_nil }

  before :each do
    allow(preset).to receive(:color).and_return(color)
    allow(preset).to receive(:base_color).and_return(base_color)
  end

  it_behaves_like 'a metadata argument', :color
  it_behaves_like 'a metadata argument', :generator
  it_behaves_like 'a forwarded metadata argument', :base_color
  it_behaves_like 'a forwarded metadata argument', :color
end
