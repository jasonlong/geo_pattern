require 'spec_helper'

RSpec.describe StructureGenerators::TrianglesGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :triangles
end
