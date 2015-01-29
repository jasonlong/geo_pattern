require 'spec_helper'

RSpec.describe StructureGenerators::TessellationGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :tessallation
end
