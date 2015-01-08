require 'spec_helper'

RSpec.describe SVG do
  context '#<=>' do
    it 'is comparable' do
      svg1 = SVG.new
      svg2 = SVG.new

      expect(svg1).to eq svg2
    end
  end
end
