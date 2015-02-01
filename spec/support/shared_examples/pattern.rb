shared_examples 'a chosen pattern' do |name|
  subject(:pattern) { GeoPattern.generate(input, patterns: name) }

  it { expect(pattern.structure).to be_name name }
end
