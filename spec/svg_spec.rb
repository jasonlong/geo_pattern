require 'spec_helper'

RSpec.describe SvgImage do
  context '#<=>' do
    it 'is comparable' do
      svg1 = SvgImage.new
      svg2 = SvgImage.new

      expect(svg1).to eq svg2
    end
  end
end
