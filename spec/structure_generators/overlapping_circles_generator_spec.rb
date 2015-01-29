require 'spec_helper'

RSpec.describe StructureGenerators::OverlappingCirclesGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :overlapping_circles
end
