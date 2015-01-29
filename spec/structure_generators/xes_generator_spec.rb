require 'spec_helper'

RSpec.describe StructureGenerators::XesGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :xes
end
