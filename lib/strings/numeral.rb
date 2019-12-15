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
    }.freeze

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

    CARDINAL_TO_ORDINAL = {
      "zero" => "zeroth",
      "one" => "first",
      "two" => "second",
      "three" => "third",
      "four" => "fourth",
      "five" => "fifth",
      "six" => "sixth",
      "seven" => "seventh",
      "eight" => "eighth",
      "nine" => "ninth",
      "ten" => "tenth",
      "eleven" => "eleventh",
      "twelve" => "twelfth",
      "thirteen" => "thirteenth",
      "fourteen" => "fourteenth",
      "fifteen" => "fifteenth",
      "sixteen" =>  "sixteenth",
      "seventeen" =>  "seventeenth",
      "eighteen" =>  "eighteenth",
      "nineteen" =>  "nineteenth",
      "twenty" =>  "twentieth",
      "thirty" =>  "thirtieth",
      "forty" => "fortieth",
      "fifty" => "fiftieth",
      "sixty" => "sixtieth",
      "seventy" => "seventieth",
      "eighty" => "eightieth",
      "ninety" => "ninetieth"
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
    ].freeze

    DECIMAL_SLOTS = [
      "tenths",
      "hundredths",
      "thousandths",
      "ten-thousandths",
      "hundred-thousandths",
      "millionths",
      "ten-millionths",
      "hundred-millionths",
      "billionths",
      "ten-billionths",
      "hundred-billionths",
      "trillionths",
      "quadrillionths",
      "quintillionths",
      "sextillionths",
      "septillionths",
      "octillionths",
      "nonillionths",
      "decillionths",
      "undecillionths",
      "duodecillionths",
      "tredecillionths",
      "quattuordecillionths",
      "quindecillionths",
      "sexdecillionths",
      "septemdecillionths",
      "octodecillionths",
      "novemdecillionths",
      "vigintillionths"
    ].freeze

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
    def cardinalize(num, **options)
      convert_numeral(num, **options)
    end
    module_function :cardinalize
    alias :cardinalise :cardinalize
    module_function :cardinalise

    # Convert a number to an ordinal numeral
    #
    # @example
    #   ordinalize(1234)
    #   # => one thousand, two hundred thirty fourth
    #
    #   ordinalize(12, short: true) # => 12th
    #
    # @param [Numeric]
    #
    # @api public
    def ordinalize(num, short: false)
      if short
        num.to_s + short_ordinalize(num)
      else
        sentence = convert_numeral(num)
        if sentence =~ /(\w+) and/
          last_digits = $1
          suffix = CARDINAL_TO_ORDINAL[last_digits]
          if suffix
            sentence.sub(/#{last_digits} and/, "#{suffix} and")
          else
            sentence
          end
        elsif sentence =~ /(\w+)$/
          last_digits = $1
          suffix = CARDINAL_TO_ORDINAL[last_digits]
          if suffix
            sentence[0...-last_digits.size] + suffix
          else
            sentence
          end
        end
      end
    end
    module_function :ordinalize
    alias :ordinalise :ordinalize
    module_function :ordinalise

    def short_ordinalize(num, short: false)
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
    def convert_numeral(num, delimiter: ",")
      negative = num < 0
      n = num.to_i.abs
      decimal = (n != num.abs)

      sentence = convert_to_words(n).join("#{delimiter} ")

      if sentence.empty?
        sentence = "zero"
      end

      if negative
        sentence = "negative " + sentence
      end

      if decimal
        sentence = sentence + " and " + convert_decimals(num)
      end

      sentence
    end
    module_function :convert_numeral

    # Convert decimal part to words
    #
    # @return [String]
    #
    # @api private
    def convert_decimals(num, delimiter: ",")
      dec_num = num.to_s.split(".")[1]
      unit = DECIMAL_SLOTS[dec_num.to_s.length - 1]

      convert_to_words(dec_num.to_i).join("#{delimiter} ") + " " + unit
    end
    module_function :convert_decimals

    # Convert an integer to number words
    #
    # @param [Integer] n
    #
    # @return [Array[String]]
    #
    # @api public
    def convert_to_words(n)
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

      words
    end
    module_function :convert_to_words

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
