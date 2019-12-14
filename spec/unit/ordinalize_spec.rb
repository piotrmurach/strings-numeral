# frozen_string_literal: true

RSpec.describe Strings::Numeral, "#ordinalize" do
  {
    0 => "0th",
    11 => "11th",
    21 => "21st",
    113 => "113th",
    123 => "123rd",
    167 => "167th",
    457 => "457th",
    -23 => "-23rd"
  }.each do |num, word|
    it "ordinalizes #{num.inspect} to short #{word.inspect}" do
      expect(Strings::Numeral.ordinalize(num)).to eq(word)
    end
  end
end
