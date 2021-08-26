# frozen_string_literal: true

RSpec.describe Strings::Numeral, "configuration" do
  it "defaults configuration values" do
    numeral = Strings::Numeral.new

    expect(numeral.configuration.currency).to eq(:usd)
    expect(numeral.configuration.decimal).to eq(:fraction)
    expect(numeral.configuration.delimiter).to eq(", ")
    expect(numeral.configuration.separator).to eq(nil)
    expect(numeral.configuration.trailing_zeros).to eq(false)
  end

  it "configures settings at initialisation" do
    numeral = Strings::Numeral.new(
      currency: "PLN",
      decimal: :digit,
      delimiter: "; ",
      separator: "dot",
      trailing_zeros: true
    )

    expect(numeral.configuration.currency).to eq("PLN")
    expect(numeral.configuration.decimal).to eq(:digit)
    expect(numeral.configuration.delimiter).to eq("; ")
    expect(numeral.configuration.separator).to eq("dot")
    expect(numeral.configuration.trailing_zeros).to eq(true)

    expect(numeral.monetize("1234.56700"))
      .to eq("one thousand; two hundred thirty four zlotys dot five seven groszy")
  end

  it "configures settings at runtime using keyword arguments" do
    numeral = Strings::Numeral.new

    numeral.configure(currency: "PLN", decimal: :digit, delimiter: "; ",
                      separator: "dot", trailing_zeros: true)

    expect(numeral.configuration.currency).to eq("PLN")
    expect(numeral.configuration.decimal).to eq(:digit)
    expect(numeral.configuration.delimiter).to eq("; ")
    expect(numeral.configuration.separator).to eq("dot")
    expect(numeral.configuration.trailing_zeros).to eq(true)

    expect(numeral.monetize("1234.56700"))
      .to eq("one thousand; two hundred thirty four zlotys dot five seven groszy")
  end

  it "configures settings at runtime for a cardinal instance" do
    numeral = Strings::Numeral.new

    numeral.configure do |config|
      config.decimal :digit
      config.delimiter "; "
      config.separator "dot"
      config.trailing_zeros true
    end

    expect(numeral.configuration.decimal).to eq(:digit)
    expect(numeral.configuration.delimiter).to eq("; ")
    expect(numeral.configuration.separator).to eq("dot")
    expect(numeral.configuration.trailing_zeros).to eq(true)

    expect(numeral.cardinalize("1234.56700"))
      .to eq("one thousand; two hundred thirty four dot five six seven zero zero")
  end

  it "configures settings at runtime for an ordinal instance" do
    numeral = Strings::Numeral.new

    numeral.configure do |config|
      config.decimal :digit
      config.delimiter "; "
      config.separator "dot"
      config.trailing_zeros true
    end

    expect(numeral.configuration.decimal).to eq(:digit)
    expect(numeral.configuration.delimiter).to eq("; ")
    expect(numeral.configuration.separator).to eq("dot")
    expect(numeral.configuration.trailing_zeros).to eq(true)

    expect(numeral.ordinalize("1234.56700"))
      .to eq("one thousand; two hundred thirty fourth dot five six seven zero zero")
  end

  it "configures settings at runtime for monetization" do
    numeral = Strings::Numeral.new

    numeral.configure do |config|
      config.currency :pln
      config.decimal :digit
      config.delimiter "; "
      config.separator "dot"
    end

    expect(numeral.configuration.currency).to eq(:pln)
    expect(numeral.configuration.decimal).to eq(:digit)
    expect(numeral.configuration.delimiter).to eq("; ")
    expect(numeral.configuration.separator).to eq("dot")

    expect(numeral.monetize("1234.56700"))
      .to eq("one thousand; two hundred thirty four zlotys dot five seven groszy")
  end
end
