require 'spec_helper'

RSpec.describe StructureGenerators::ConcentricCirclesGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :concentric_circles
end
