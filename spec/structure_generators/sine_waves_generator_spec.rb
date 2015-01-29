require 'spec_helper'

RSpec.describe StructureGenerators::SineWavesGenerator do
  it_behaves_like 'a structure generator', :sine_waves
end
