RSpec.shared_examples 'a chosen pattern' do |name|
  subject(:pattern) { GeoPattern.generate(input, patterns: name) }

  let(:file_name) { "#{name}.svg" }

  before :each do
    write_file file_name, pattern.to_s
  end

  it { expect(pattern.structure).to be_name name }
  it { expect(file_name).to have_same_file_content_like("%/generated_patterns/#{name}.svg") }
end

RSpec.shared_examples 'an invalid pattern' do |chosen_pattern|
  subject(:pattern) { GeoPattern.generate(input, patterns: chosen_pattern) }

  it { expect { subject }.to raise_error InvalidPatternError }
end

RSpec.shared_examples 'an old style pattern' do |chosen_pattern, name|
  subject(:pattern) { GeoPattern.generate(input, patterns: chosen_pattern) }

  let(:file_name) { "#{name}.svg" }

  before :each do
    write_file file_name, pattern.to_s
  end

  it { expect(pattern.structure).to be_name name }
  it { expect(file_name).to have_same_file_content_like("%/generated_patterns/#{name}.svg") }
end
