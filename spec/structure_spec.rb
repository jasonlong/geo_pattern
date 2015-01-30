require 'spec_helper'

RSpec.describe Structure do
  subject(:metadata) { described_class.new(image: svg_image, preset: preset, generator: generator, name: name) }

  let(:svg_image) { instance_double('GeoPattern::SvgImage') }
  let(:svg_image_content) { fixtures_path('generated_patterns/sine_waves.svg').read.chomp }
  let(:preset) { instance_double('GeoPattern::PatternPreset') }
  let(:generator) { stub_const('GeoPattern::StructureGenerators::ChevronGenerator', Class.new) }

  let(:name) { :chevron }
  let(:fill_color_dark) { '#222' }
  let(:fill_color_light) { '#ddd' }
  let(:stroke_color) { '#000' }
  let(:stroke_opacity) { 0.02 }
  let(:opacity_min) { 0.02 }
  let(:opacity_max) { 0.15 }

  it { is_expected.not_to be_nil }

  before :each do
    allow(preset).to receive(:fill_color_dark).and_return(fill_color_dark)
    allow(preset).to receive(:fill_color_light).and_return(fill_color_light)
    allow(preset).to receive(:stroke_color).and_return(stroke_color)
    allow(preset).to receive(:stroke_opacity).and_return(stroke_opacity)
    allow(preset).to receive(:opacity_min).and_return(opacity_min)
    allow(preset).to receive(:opacity_max).and_return(opacity_max)
  end

  it_behaves_like 'a metadata argument', :name
  it_behaves_like 'a metadata argument', :generator
  it_behaves_like 'a forwarded metadata argument', :fill_color_dark
  it_behaves_like 'a forwarded metadata argument', :fill_color_light
  it_behaves_like 'a forwarded metadata argument', :stroke_color
  it_behaves_like 'a forwarded metadata argument', :stroke_opacity
  it_behaves_like 'a forwarded metadata argument', :opacity_min
  it_behaves_like 'a forwarded metadata argument', :opacity_max
end
