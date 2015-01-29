require 'spec_helper'

RSpec.describe StructureGenerators::PlusSignsGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :plus_signs
end
