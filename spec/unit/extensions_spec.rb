# frozen_string_literal: true

require "strings/numeral/extensions"

using Strings::Numeral::Extensions

RSpec.describe Strings::Numeral::Extensions, "extensions" do
  context "when String" do
    it "cardinalizes a number" do
      expect("12.34".numeralize).to eq("twelve and thirty four hundredths")
    end

    it "cardinalizes a number" do
      expect("12.34".cardinalize).to eq("twelve and thirty four hundredths")
    end

    it "ordinalizes a number" do
      expect("12.34".ordinalize).to eq("twelfth and thirty four hundredths")
    end

    it "ordinalizes a number" do
      expect("12.34".ordinalize_short).to eq("12th")
    end

    it "monetizes a number" do
      expect("12.34".monetize).to eq("twelve dollars and thirty four cents")
    end

    it "romanizes a number" do
      expect("12".romanize).to eq("XII")
    end
  end

  context "when Float" do
    it "cardinalizes a number" do
      expect(12.34.cardinalize).to eq("twelve and thirty four hundredths")
    end

    it "ordinalizes a number" do
      expect(12.34.ordinalize).to eq("twelfth and thirty four hundredths")
    end

    it "monetizes a number" do
      expect(12.34.monetize).to eq("twelve dollars and thirty four cents")
    end

    it "romanizes a number" do
      expect(12.1.romanize).to eq("XII")
    end
  end

  context "when Integer" do
    it "cardinalizes a number" do
      expect(12.cardinalize).to eq("twelve")
    end

    it "ordinalizes a number" do
      expect(12.ordinalize).to eq("twelfth")
    end

    it "monetizes a number" do
      expect(12.monetize).to eq("twelve dollars")
    end

    it "romanizes a number" do
      expect(12.romanize).to eq("XII")
    end
  end
end
