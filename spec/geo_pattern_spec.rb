# encoding: utf-8
require 'spec_helper'

RSpec.describe GeoPattern do
  subject(:pattern) { GeoPattern.generate(input) }
  let(:input) { 'Mastering Markdown' }
  let(:color) { '#ffcc00' }
  let(:rgb_base_color) { PatternHelpers.html_to_rgb_for_string(seed, color) }
  let(:seed) { instance_double('GeoPattern::Seed') }

  before :each do
    allow(seed).to receive(:to_i).with(14, 3).and_return(2616)
    allow(seed).to receive(:to_i).with(17, 1).and_return(3)
  end

  it { expect(pattern).not_to be_nil }

  describe '.generate' do
    context 'when invoked with the same input it returns the same output' do
      let(:other_pattern) { GeoPattern.generate(input) }
      it { expect(pattern.to_svg).to eq other_pattern.to_svg }
    end

    context 'when an invalid option is given' do
      subject(:pattern) { GeoPattern.generate(input, **args) }
      let(:args) { { unknown: true } }

      it { expect { pattern }.to raise_error ArgumentError }
    end

    context 'set background color of generated pattern' do
      let(:new_color) { '#ffcc00' }

      context 'when a base color is set' do
        subject(:pattern) { GeoPattern.generate(input, base_color: color) }
        let(:new_color) { '#04fbf6' }

        it { expect(pattern.background.color.to_html).to eq(new_color) }
      end

      context 'when a color is set' do
        subject(:pattern) { GeoPattern.generate(input, color: color) }

        it { expect(pattern.background.color.to_html).to eq(new_color) }
      end
    end

    context 'specify the pattern' do
      subject(:pattern) { GeoPattern.generate(input, patterns: chosen_pattern) }

      let(:chosen_pattern) { :sine_waves }

      context 'when the deprecated generator option is used' do
        subject(:pattern) { GeoPattern.generate(input, generator: chosen_pattern) }
        subject(:other_pattern) { GeoPattern.generate(input, patterns: chosen_pattern) }

        it { expect { pattern.to_svg }.to output(/deprecated/).to_stderr }
        it { silence(:stderr) { expect(pattern.to_svg).to eq other_pattern.to_svg } }
      end

      context 'when multiple patterns are selected' do
        let(:chosen_pattern) { [:sine_waves, :xes] }

        it { expect(pattern.structure.name).to eq(:sine_waves).or eq(:xes) }
      end

      context 'when an old style pattern was chosen via class name' do
        it_behaves_like 'an old style pattern', ChevronPattern, :chevrons
        it_behaves_like 'an old style pattern', ConcentricCirclesPattern, :concentric_circles
        it_behaves_like 'an old style pattern', DiamondPattern, :diamonds
        it_behaves_like 'an old style pattern', HexagonPattern, :hexagons
        it_behaves_like 'an old style pattern', MosaicSquaresPattern, :mosaic_squares
        it_behaves_like 'an old style pattern', NestedSquaresPattern, :nested_squares
        it_behaves_like 'an old style pattern', OctagonPattern, :octagons
        it_behaves_like 'an old style pattern', OverlappingCirclesPattern, :overlapping_circles
        it_behaves_like 'an old style pattern', OverlappingRingsPattern, :overlapping_rings
        it_behaves_like 'an old style pattern', PlaidPattern, :plaid
        it_behaves_like 'an old style pattern', PlusSignPattern, :plus_signs
        it_behaves_like 'an old style pattern', SineWavePattern, :sine_waves
        it_behaves_like 'an old style pattern', SquarePattern, :squares
        it_behaves_like 'an old style pattern', TessellationPattern, :tessellation
        it_behaves_like 'an old style pattern', TrianglePattern, :triangles
        it_behaves_like 'an old style pattern', XesPattern, :xes
      end

      context 'when an valid pattern was chosen' do
        it_behaves_like 'a chosen pattern', :chevrons
        it_behaves_like 'a chosen pattern', :concentric_circles
        it_behaves_like 'a chosen pattern', :diamonds
        it_behaves_like 'a chosen pattern', :hexagons
        it_behaves_like 'a chosen pattern', :mosaic_squares
        it_behaves_like 'a chosen pattern', :nested_squares
        it_behaves_like 'a chosen pattern', :octagons
        it_behaves_like 'a chosen pattern', :overlapping_circles
        it_behaves_like 'a chosen pattern', :overlapping_rings
        it_behaves_like 'a chosen pattern', :plaid
        it_behaves_like 'a chosen pattern', :plus_signs
        it_behaves_like 'a chosen pattern', :sine_waves
        it_behaves_like 'a chosen pattern', :squares
        it_behaves_like 'a chosen pattern', :tessellation
        it_behaves_like 'a chosen pattern', :triangles
        it_behaves_like 'a chosen pattern', :xes
      end

      context 'when invalid patterns were chosen' do
        InvalidPatternClass = Class.new

        it_behaves_like 'an invalid pattern', InvalidPatternClass
        it_behaves_like 'an invalid pattern', 'invalid_pattern'
        it_behaves_like 'an invalid pattern', :invalid_pattern
        it_behaves_like 'an invalid pattern', [:sine_waves, 'invalid_pattern']
      end
    end
  end
end
