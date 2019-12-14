# frozen_string_literal: true

require_relative "numeral/version"

module Strings
  module Numeral
    class Error < StandardError; end

    CARDINAL_TO_SHORT_ORDINAL = {
      0 => "th",
      1 => "st",
      11 => "th",
      2 => "nd",
      12 => "th",
      3 => "rd",
      13 => "th",
      4 => "th",
      5 => "th",
      6 => "th",
      7 => "th",
      8 => "th",
      9 => "th"
    }.freeze

    def ordinalize(num)
      num.to_s + short_ordinalize(num)
    end
    module_function :ordinalize
    alias :ordinalise :ordinalize
    module_function :ordinalise

    def short_ordinalize(num)
      num_abs = num.abs

      CARDINAL_TO_SHORT_ORDINAL[num_abs % 100] ||
        CARDINAL_TO_SHORT_ORDINAL[num_abs % 10]
    end
    module_function :short_ordinalize
  end # Numeral
end # Strings
