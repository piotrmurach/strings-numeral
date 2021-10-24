# frozen_string_literal: true

RSpec.describe Strings::Numeral, "#romanize" do
  {
    1 => "I",
    5 => "V",
    9 => "IX",
    15 => "XV",
    155 => "CLV",
    555 => "DLV",
    1111 => "MCXI",
    2020 => "MMXX",
    "3456" => "MMMCDLVI",
    4999 => "MMMMCMXCIX"
  }.each do |num, word|
    it "romanizes #{num.inspect} to #{word.inspect}" do
      expect(Strings::Numeral.romanize(num)).to eq(word)
    end
  end

  it "raises when integer is above the range" do
    expect {
      Strings::Numeral.romanize(5000)
    }.to raise_error(Strings::Numeral::Error, "'5000' is out of range")
  end

  it "raises when integer below the range" do
    expect {
      Strings::Numeral.romanize(0)
    }.to raise_error(Strings::Numeral::Error, "'0' is out of range")
  end

  it "checks value in strict mode as not a number" do
    expect {
      Strings::Numeral.romanize("unknown", strict: true)
    }.to raise_error(Strings::Numeral::Error, "not a number: \"unknown\"")
  end
end
