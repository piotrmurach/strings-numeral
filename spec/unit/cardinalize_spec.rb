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
    1234567 => "one million, two hundred thirty four thousand, five hundred sixty seven",
    -125 => "negative one hundred twenty five",
    0.1 => "zero and one tenths",
    0.21 => "zero and twenty one hundredths",
    1.23 => "one and twenty three hundredths",
    12.003 => "twelve and three thousandths",
    123.456 => "one hundred twenty three and four hundred fifty six thousandths",
    -114.5678 => "negative one hundred fourteen and five thousand, six hundred seventy eight ten-thousandths",
    1234.567 => "one thousand, two hundred thirty four and five hundred sixty seven thousandths",
    -3456.07 => "negative three thousand, four hundred fifty six and seven hundredths"
  }.each do |num, word|
    it "cardinalizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.cardinalize(num)).to eq(word)
    end
  end

  {
    0.1 => "zero point one",
    0.21 => "zero point two one",
    1.23 => "one point two three",
    12.003 => "twelve point zero zero three",
    123.456 => "one hundred twenty three point four five six",
    -114.5678 => "negative one hundred fourteen point five six seven eight",
    1234.567 => "one thousand, two hundred thirty four point five six seven",
    -3456.07 => "negative three thousand, four hundred fifty six point zero seven"
  }.each do |num, word|
    it "cardinalizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.cardinalize(num, decimal: :digit)).to eq(word)
    end
  end

  it "doesn't recognise :decimal option" do
    expect {
      Strings::Numeral.cardinalize(123.45, decimal: :unknown)
    }.to raise_error(Strings::Numeral::Error, "Unknown decimal option ':unknown'")
  end
end
