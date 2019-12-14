# frozen_string_literal: true

require_relative "numeral/version"

module Strings
  module Numeral
    class Error < StandardError; end

    CARDINALS = {
      0 => "",
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine",
      10 => "ten",
      11 => "eleven",
      12 => "twelve",
      13 => "thirteen",
      14 => "fourteen",
      15 => "fifteen",
      16 => "sixteen",
      17 => "seventeen",
      18 => "eighteen",
      19 => "nineteen",
      20 => "twenty",
      30 => "thirty",
      40 => "forty",
      50 => "fifty",
      60 => "sixty",
      70 => "seventy",
      80 => "eighty",
      90 => "ninety",
    }

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

    SCALES = [
      "hundreds-tens-ones",
      "thousand",
      "million",
      "billion",
      "trillion",
      "quadrillion",
      "quintillion",
      "sextillion",
      "septillion",
      "octillion",
      "nonillion",
      "decillion",
      "undecillion",
      "duodecillion",
      "tredecillion",
      "quattuordecillion",
      "quindecillion",
      "sexdecillion",
      "septemdecillion",
      "octodecillion",
      "novemdecillion",
      "vigintillion"
    ]

    # Convert a number to a cardinal numeral
    #
    # @example
    #   cardinalize(1234)
    #   # => one thousand, two hundred thirty four
    #
    # @param [Numeric] num
    #
    # @return [String]
    #
    # @api public
    def cardinalize(num)
      convert_numeral(num)
    end
    module_function :cardinalize
    alias :cardinalise :cardinalize
    module_function :cardinalise

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

    # Convert a number into a numeral
    #
    # @param [Numeric] num
    #   the number to convert to numeral
    #
    # @return [String]
    #   the number as numeral
    #
    # @api private
    def convert_numeral(num)
      n = num.to_i
      words = []

      SCALES.each_with_index do |scale, i|
        mod = n % 1000

        word = []
        word << convert_hundreds(mod)
        word << scale unless i.zero?

        words.insert(0, word.join(" "))

        n /= 1000

        break if n.zero?
      end

      if words.join.empty?
        return "zero"
      end

      words.join(", ")
    end
    module_function :convert_numeral

    # Convert 3 digit number to equivalent word
    #
    # @return [String]
    #
    # @api private
    def convert_hundreds(num)
      word = []
      hundreds = (num % 1000) / 100
      tens = num % 100

      if !hundreds.zero?
        word << convert_tens(hundreds)
        word << "hundred"
      end

      if !tens.zero?
        word << convert_tens(tens)
      end

      word.join(" ")
    end
    module_function :convert_hundreds

    # Convert number in 0..99 range to equivalent word
    #
    # @return [String]
    #
    # @api private
    def convert_tens(num)
      word = []
      tens = num % 100

      if tens.to_s.size < 2 || tens <= 20
        word << CARDINALS[tens]
      else
        word << CARDINALS[(tens / 10) * 10]
        word << CARDINALS[tens % 10]
      end

      word.join(" ")
    end
    module_function :convert_tens
  end # Numeral
end # Strings
