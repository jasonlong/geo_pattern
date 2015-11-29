# encoding: utf-8
require 'aruba/api'
require 'aruba/reporting'

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
  c.include SpecHelper::Aruba

  c.before :each do
    setup_aruba
    restore_env
  end
end
