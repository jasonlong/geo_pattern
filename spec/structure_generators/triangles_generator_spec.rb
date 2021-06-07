# frozen_string_literal: true

require "spec_helper"

RSpec.describe StructureGenerators::TrianglesGenerator do
  it_behaves_like "a structure generator", :triangles
end
