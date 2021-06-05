# frozen_string_literal: true

require "spec_helper"

RSpec.describe StructureGenerators::SquaresGenerator do
  it_behaves_like "a structure generator", :squares
end
