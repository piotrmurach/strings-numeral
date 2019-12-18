# frozen_string_literal: true

RSpec.describe Strings::Numeral, "#monetize" do
  {
    1 => "one dollar",
    20 => "twenty dollars",
    21 => "twenty one dollars",
    100 => "one hundred dollars",
    1234 => "one thousand, two hundred thirty four dollars",
    12345 => "twelve thousand, three hundred forty five dollars",
    123456 => "one hundred twenty three thousand, four hundred fifty six dollars",
    1234567 => "one million, two hundred thirty four thousand, five hundred sixty seven dollars",
    -125 => "negative one hundred twenty five dollars",
    0.1 => "zero dollars and ten cents",
    0.7 => "zero dollars and seventy cents",
    0.01 => "zero dollars and one cent",
    0.21 => "zero dollars and twenty one cents",
    0.1234 => "zero dollars and twelve cents",
    12.100 => "twelve dollars and ten cents",
    12.000 => "twelve dollars",
    123.456 => "one hundred twenty three dollars and forty six cents",
    -114.5678 => "negative one hundred fourteen dollars and fifty seven cents",
    1234.567 => "one thousand, two hundred thirty four dollars and fifty seven cents",
    -3456.07 => "negative three thousand, four hundred fifty six dollars and seven cents"
  }.each do |num, word|
    it "monetizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.monetize(num)).to eq(word)
    end
  end

  it "monetizes 123.45 in EUR " do
    expect(Strings::Numeral.monetize(123.456, currency: :eur)).
      to eq("one hundred twenty three euros and forty six cents")
  end

  it "monetizes 123.45 in GBP " do
    expect(Strings::Numeral.monetize(123.456, currency: :gbp)).
      to eq("one hundred twenty three pounds and forty six pence")
  end

  it "monetizes 123.45 in JPY " do
    expect(Strings::Numeral.monetize(123.456, currency: :jpy)).
      to eq("one hundred twenty three yen and forty six sen")
  end

  it "monetizes 123.45 in PLN " do
    expect(Strings::Numeral.monetize(123.456, currency: :pln)).
      to eq("one hundred twenty three zlotys and forty six groszy")
  end
end
