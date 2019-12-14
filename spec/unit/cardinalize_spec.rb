# frozen_string_literal: true

RSpec.describe Strings::Numeral, "#cardinalize" do
  {
    0 => "zero",
    1 => "one",
    20 => "twenty",
    21 => "twenty one",
    100 => "one hundred",
    101 => "one hundred one",
    111 => "one hundred eleven",
    113 => "one hundred thirteen",
    123 => "one hundred twenty three",
    1234 => "one thousand, two hundred thirty four",
    12345 => "twelve thousand, three hundred forty five",
    123456 => "one hundred twenty three thousand, four hundred fifty six",
    1234567 => "one million, two hundred thirty four thousand, five hundred sixty seven"
  }.each do |num, word|
    it "cardinalizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.cardinalize(num)).to eq(word)
    end
  end
end
