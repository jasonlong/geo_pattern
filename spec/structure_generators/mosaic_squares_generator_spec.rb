# frozen_string_literal: true

require "spec_helper"

RSpec.describe StructureGenerators::MosaicSquaresGenerator do
  it_behaves_like "a structure generator", :mosaic_squares
end
