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
      expect(Strings::Numeral.ordinalize(num, short: true)).to eq(word)
    end
  end

  {
    0 => "zeroth",
    1 => "first",
    20 => "twentieth",
    21 => "twenty first",
    100 => "one hundred",
    101 => "one hundred first",
    111 => "one hundred eleventh",
    113 => "one hundred thirteenth",
    123 => "one hundred twenty third",
    1234 => "one thousand, two hundred thirty fourth",
    12345 => "twelve thousand, three hundred forty fifth",
    123456 => "one hundred twenty three thousand, four hundred fifty sixth",
    1234567 => "one million, two hundred thirty four thousand, five hundred sixty seventh",
    -125 => "negative one hundred twenty fifth",
  }.each do |num, word|
    it "ordinalizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.ordinalize(num)).to eq(word)
    end
  end
end
