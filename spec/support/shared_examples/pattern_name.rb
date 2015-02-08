shared_examples 'a known pattern name' do
  it { silence(:stderr) { expect(pattern_store[pattern_name]).not_to be_nil } }
end

shared_examples 'an unknown pattern name' do
  it { silence(:stderr) { expect(pattern_store[pattern_name]).to be_nil } }
end
