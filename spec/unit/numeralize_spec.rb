# frozen_string_literal: true

RSpec.describe Strings::Numeral, "#numeralize" do
  it "converts a number to cardinal numeral by default" do
    expect(Strings::Numeral.numeralize(1234.567))
      .to eq("one thousand, two hundred thirty four and " \
             "five hundred sixty seven thousandths")
  end

  it "converts a number to ordinal numeral with a term" do
    expect(Strings::Numeral.numeralize(1234.567, term: :ord))
      .to eq("one thousand, two hundred thirty fourth and " \
             "five hundred sixty seven thousandths")
  end
end
