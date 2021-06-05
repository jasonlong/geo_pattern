# frozen_string_literal: true

module SpecHelper
  module Fixtures
    def fixtures_path(name)
      base_path = Pathname.new(File.expand_path("../../../fixtures", __dir__))
      base_path + Pathname.new(name)
    end
  end
end

RSpec.configure do |c|
  c.include SpecHelper::Fixtures
end
