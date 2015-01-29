require 'spec_helper'

RSpec.describe StructureGenerators::OctagonsGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :octagons
end
