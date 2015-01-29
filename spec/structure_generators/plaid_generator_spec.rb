require 'spec_helper'

RSpec.describe StructureGenerators::PlaidGenerator do
  it_behaves_like 'a structure generator'
  it_behaves_like 'a named generator', :plaid
end
