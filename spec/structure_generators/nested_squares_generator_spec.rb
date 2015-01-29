require 'spec_helper'

RSpec.describe StructureGenerators::NestedSquaresGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :nested_squares
end
