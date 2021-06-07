# frozen_string_literal: true

module GeoPattern
  # user errors
  class UserError < StandardError; end

  # raised if an invalid pattern is requested
  class InvalidPatternError < UserError; end
end
