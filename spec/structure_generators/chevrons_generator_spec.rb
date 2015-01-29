require 'spec_helper'

RSpec.describe StructureGenerators::ChevronsGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :chevrons
end
