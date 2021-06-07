# frozen_string_literal: true

require "spec_helper"

RSpec.describe StructureGenerators::PlaidGenerator do
  it_behaves_like "a structure generator", :plaid
end
