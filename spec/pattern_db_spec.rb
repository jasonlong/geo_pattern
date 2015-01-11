require 'spec_helper'

RSpec.describe PatternDb, :focus do
  context '#fetch' do
    it 'returns a all available patterns if empty' do
      db = PatternDb.new
      patterns = db.fetch(nil)

      expect(patterns.size).to eq 16
    end

    it 'returns a all available patterns if empty' do
      db = PatternDb.new
      patterns = db.fetch([])

      expect(patterns.size).to eq 16
    end

    it 'returns a requested pattern (class) as class' do
      db = PatternDb.new

      requested_pattern = GeoPattern::XesPattern
      pattern = db.fetch(requested_pattern)

      expect(pattern.first).to be requested_pattern
    end

    it 'returns a requested pattern (string) as class' do
      db = PatternDb.new

      requested_pattern = 'xes'
      pattern = db.fetch(requested_pattern)

      expect(pattern.first).to be GeoPattern::XesPattern
    end

    it 'returns a requested pattern (string) as class' do
      expect {
        PatternDb.new.fetch('invalid')
      }.to raise_error GeoPattern::InvalidPatternError
    end
  end
end
