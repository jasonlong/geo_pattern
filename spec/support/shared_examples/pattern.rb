shared_examples 'a chosen pattern' do |name|
  subject(:pattern) { GeoPattern.generate(input, patterns: name) }
  let(:file_name) { "#{name}.svg" }

  before :each do
    write_file file_name, pattern.to_s
  end

  it { expect(pattern.structure).to be_name name }
  it { check_binary_file_content(file_name, fixtures_path("generated_patterns/#{name}.svg")) }
end
