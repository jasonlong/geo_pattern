require 'spec_helper'

RSpec.describe StructureGenerators::MosaicSquaresGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :mosaic_squares
end
