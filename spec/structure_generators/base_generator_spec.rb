require 'spec_helper'

RSpec.describe StructureGenerators::BaseGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :base
end
