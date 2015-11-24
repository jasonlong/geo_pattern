# encoding: utf-8
require 'aruba/api'
require 'aruba/reporting'
require 'aruba/rspec'

# Spec Helpers
module SpecHelper
  # Helpers for aruba
  module Aruba
    include ::Aruba::Api

    def dirs
      @dirs ||= %w(tmp rspec)
    end
  end
end

RSpec.configure do |c|
  c.before :each do
    # restore_env
    setup_aruba
  end
end
