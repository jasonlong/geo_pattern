shared_examples 'a valid pattern name' do
  it do
    silence(:stderr) { expect(pattern_store[pattern_name]).not_to be_nil }
  end
end
