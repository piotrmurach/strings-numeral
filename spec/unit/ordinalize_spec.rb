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
    0.1 => "zeroth and one tenths",
    0.21 => "zeroth and twenty one hundredths",
    1.23 => "first and twenty three hundredths",
    12.003 => "twelfth and three thousandths",
    123.456 => "one hundred twenty third and four hundred fifty six thousandths",
    -114.5678 => "negative one hundred fourteenth and five thousand, six hundred seventy eight ten-thousandths",
    1234.567 => "one thousand, two hundred thirty fourth and five hundred sixty seven thousandths",
    -3456.07 => "negative three thousand, four hundred fifty sixth and seven hundredths"
  }.each do |num, word|
    it "ordinalizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.ordinalize(num)).to eq(word)
    end
  end

  {
    0.1 => "zeroth point one",
    0.21 => "zeroth point two one",
    1.23 => "first point two three",
    12.003 => "twelfth point zero zero three",
    123.456 => "one hundred twenty third point four five six",
    -114.5678 => "negative one hundred fourteenth point five six seven eight",
    1234.567 => "one thousand, two hundred thirty fourth point five six seven",
    -3456.07 => "negative three thousand, four hundred fifty sixth point zero seven"
  }.each do |num, word|
    it "ordinalizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.ordinalize(num, decimal: :digit)).to eq(word)
    end
  end

  it "allows to change a thousand's delimiter" do
    expect(Strings::Numeral.ordinalize(1_234_567, delimiter: " and ")).
      to eq("one million and two hundred thirty four thousand and five hundred sixty seventh")
  end

  it "changes a separator between fractional and integer numerals" do
    expect(Strings::Numeral.ordinalize(1_234.567, separator: "dot")).
      to eq("one thousand, two hundred thirty fourth dot five hundred sixty seven thousandths")
  end
end
