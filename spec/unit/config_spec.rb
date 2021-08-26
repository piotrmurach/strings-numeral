# frozen_string_literal: true

RSpec.describe Strings::Numeral, "configuration" do
  it "configures options for a cardinal instance" do
    numeral = Strings::Numeral.new do |config|
      config.delimiter "; "
      config.separator "dot"
      config.decimal :digit
      config.trailing_zeros true
    end

    expect(numeral.cardinalize("1234.56700"))
      .to eq("one thousand; two hundred thirty four dot five six seven zero zero")
  end

  it "configures options for an ordinal instance" do
    numeral = Strings::Numeral.new do |config|
      config.delimiter "; "
      config.separator "dot"
      config.decimal :digit
      config.trailing_zeros true
    end

    expect(numeral.ordinalize("1234.56700"))
      .to eq("one thousand; two hundred thirty fourth dot five six seven zero zero")
  end

  it "configures options for monetization" do
    numeral = Strings::Numeral.new do |config|
      config.delimiter "; "
      config.separator "dot"
      config.decimal :digit
      config.currency :pln
    end

    expect(numeral.monetize("1234.56700"))
      .to eq("one thousand; two hundred thirty four zlotys dot five seven groszy")
  end
end
