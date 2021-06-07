# frozen_string_literal: true

require "aruba/rspec"
require "aruba/api"

# Spec Helpers
module SpecHelper
  # Helpers for aruba
  module Aruba
    include ::Aruba::Api

    def dirs
      @dirs ||= %w[tmp rspec]
    end
  end
end

RSpec.configure do |c|
  c.include SpecHelper::Aruba

  c.before :each do
    setup_aruba
  end
end
