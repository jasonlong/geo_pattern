# encoding: utf-8
require 'spec_helper'

RSpec.describe GeoPattern do
  subject(:pattern) { GeoPattern.generate(input) }
  let(:input) { 'Mastering Markdown' }
  let(:seed) { instance_double('GeoPattern::Seed') }
  let(:color) { '#fc0' }
  let(:rgb_base_color) { PatternHelpers.html_to_rgb_for_string(seed, color) }

  before :each do
    binding.pry
    allow(seed).to receive(:to_i).and_return(1)
  end

  it { expect(pattern).not_to be_nil }

  describe '.generate' do
    context 'when invoked with the same input it returns the same output' do
      let(:other_pattern) { GeoPattern.generate(input) }
      it { expect(pattern.to_svg).to eq other_pattern.to_svg }
    end

    context 'set background color of generated pattern' do
      context 'when a base color is set' do
        subject(:pattern) { GeoPattern.generate(input, base_color: color) }

        it { expect(pattern.to_svg).to include(rgb_base_color) }
      end

      context 'when a color is set' do
        subject(:pattern) { GeoPattern.generate(input, color: color) }
        let(:rgb_base_color) { PatternHelpers.html_to_rgb(color) }

        it { expect(pattern.to_svg).to include(rgb_base_color) }
      end
    end

    context 'specify the generator' do
      subject(:pattern) { GeoPattern.generate(input, pattern: chosen_pattern) }
      let(:chosen_pattern) { :sine_waves }

      context 'when the deprecated generator option is used' do
        subject(:pattern) { GeoPattern.generate(input, generator: chosen_pattern) }
        subject(:other_pattern) { GeoPattern.generate(input, patterns: chosen_pattern) }

        it { expect{ pattern.to_svg }.to output(/deprecated/).to_stderr }
        it { expect(pattern.to_svg).to eq other_pattern.to_svg }
      end

      context 'when a single pattern is selected' do
        it { expect(pattern).not_to be_nil }
      end

      context 'when multiple patterns are selected' do
        let(:chosen_pattern) { [:sine_waves, :xes] }
        it { expect(pattern).not_to be_nil }
      end

      context 'when an invalid generator was chosen' do
        context 'single symbol pattern name' do
          it { expect { GeoPattern.generate(input, patterns: :invalid_pattern) }.to raise_error InvalidPatternError }
        end

        context 'single string pattern name' do
          it { expect { GeoPattern.generate(input, patterns: 'invalid_pattern') }.to raise_error InvalidPatternError }
        end

        context 'single class pattern name' do
          class InvalidPatternClass; end

          it { expect { GeoPattern.generate(input, patterns: InvalidPatternClass) }.to raise_error InvalidPatternError }
        end

        context 'multiple string patterns' do
          it { expect { GeoPattern.generate(input, patterns: [:sine_waves, 'invalid_pattern']) }.to raise_error InvalidPatternError }
        end
      end
    end
  end
end
