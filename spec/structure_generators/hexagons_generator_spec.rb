# frozen_string_literal: true

require "spec_helper"

RSpec.describe StructureGenerators::HexagonsGenerator do
  it_behaves_like "a structure generator", :hexagons
end
