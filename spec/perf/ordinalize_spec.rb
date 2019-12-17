# frozen_string_literal: true

require "rspec-benchmark"
require "active_support"

RSpec.describe Strings::Numeral do
  include RSpec::Benchmark::Matchers

  it "converts number to short ordinal faster than ActiveSupport" do
    expect {
      Strings::Numeral.ordinalize_short(12345)
    }.to perform_faster_than {
      ActiveSupport::Inflector.ordinalize(12345)
    }.at_least(350).times
  end

  it "converts number to ordinal 10 times faster than ActiveSupport" do
    expect {
      Strings::Numeral.ordinalize(12345)
    }.to perform_faster_than {
      ActiveSupport::Inflector.ordinalize(12345)
    }.at_least(10).times
  end
end
