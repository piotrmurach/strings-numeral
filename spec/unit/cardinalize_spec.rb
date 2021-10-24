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
    0.1 => "zero and one tenth",
    0.01 => "zero and one hundredth",
    0.21 => "zero and twenty one hundredths",
    1.23 => "one and twenty three hundredths",
    12.003 => "twelve and three thousandths",
    0.001 => "zero and one thousandth",
    12.100 => "twelve and one tenth",
    12.000 => "twelve",
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
    12.100 => "twelve point one",
    12.000 => "twelve",
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

  it "allows to change a thousand's delimiter" do
    expect(Strings::Numeral.cardinalise(1_234_567, delimiter: " and "))
      .to eq("one million and two hundred thirty four thousand and five hundred sixty seven")
  end

  it "changes a separator between fractional and integer numerals" do
    expect(Strings::Numeral.cardinalize(1_234.567, separator: "dot"))
      .to eq("one thousand, two hundred thirty four dot five hundred sixty seven thousandths")
  end

  it "removes trailing zeros for strings to match number behaviour" do
    expect(Strings::Numeral.cardinalize("12.100")).to eq("twelve and one tenth")
  end

  it "keeps trailing zeros for strings when :trailing_zeros is set to true" do
    expect(Strings::Numeral.cardinalize("12.100", trailing_zeros: true))
      .to eq("twelve and one hundred thousandths")
  end

  it "keeps trailing zeros for strings with only one zero" do
    expect(Strings::Numeral.cardinalize("12.70", trailing_zeros: true))
      .to eq("twelve and seventy hundredths")
  end

  it "keeps trailing zeros when decimal format is digit" do
    expect(Strings::Numeral.cardinalize("12.100", trailing_zeros: true, decimal: :digit))
      .to eq("twelve point one zero zero")
  end

  it "checks value in strict mode as not a number" do
    expect {
      Strings::Numeral.cardinalize("unknown", strict: true)
    }.to raise_error(Strings::Numeral::Error, "not a number: \"unknown\"")
  end
end
