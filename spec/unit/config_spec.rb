# frozen_string_literal: true

RSpec.describe Strings::Numeral, "" do
  it "configures options for a cardinal instance" do
    numeral = Strings::Numeral.new do |config|
      config.delimiter "; "
      config.separator "dot"
      config.decimal :digit
    end

    expect(numeral.cardinalize(1234.567)).
      to eq("one thousand; two hundred thirty four dot five six seven")
  end

  it "configures options for an ordinal instance" do
    numeral = Strings::Numeral.new do |config|
      config.delimiter "; "
      config.separator "dot"
      config.decimal :digit
    end

    expect(numeral.ordinalize(1234.567)).
      to eq("one thousand; two hundred thirty fourth dot five six seven")
  end
end
