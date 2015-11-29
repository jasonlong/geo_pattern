RSpec.shared_examples 'a known pattern name', type: :aruba do
  it { silence(:stderr) { expect(pattern_store[pattern_name]).not_to be_nil } }
end

RSpec.shared_examples 'an unknown pattern name', type: :aruba do
  it { silence(:stderr) { expect(pattern_store[pattern_name]).to be_nil } }
end
