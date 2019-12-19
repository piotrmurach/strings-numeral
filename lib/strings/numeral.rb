# frozen_string_literal: true

require "forwardable"

require_relative "numeral/configuration"
require_relative "numeral/version"

module Strings
  class Numeral
    class Error < StandardError; end

    NEGATIVE = "negative"
    HUNDRED = "hundred"
    ZERO = "zero"
    AND = "and"
    POINT = "point"
    SPACE = " "

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

    CARDINAL_TO_ROMAN = {
      1 => "I",
      4 => "IV",
      5 => "V",
      9 => "IX",
      10 => "X",
      40 => "XL",
      50 => "L",
      90 => "XC",
      100 => "C",
      400 => "CD",
      500 => "D",
      900 => "CM",
      1000 => "M"
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

    CURRENCIES = {
      eur: {
        unit: "euro",
        units: "euros",
        decimal_unit: "cent",
        decimal_units: "cents"
      },
      gbp: {
        unit: "pound",
        units: "pounds",
        decimal_unit: "pence",
        decimal_units: "pence",
      },
      jpy: {
        unit: "yen",
        units: "yen",
        decimal_unit: "sen",
        decimal_units: "sen",
      },
      pln: {
        unit: "zloty",
        units: "zlotys",
        decimal_unit: "grosz",
        decimal_units: "groszy"
      },
      usd: {
        unit: "dollar",
        units: "dollars",
        decimal_unit: "cent",
        decimal_units: "cents"
      }
    }.freeze

    def self.instance
      @instance ||= Numeral.new
    end

    class << self
      extend Forwardable

      delegate %i[numeralize cardinalize cardinalise ordinalize
                  ordinalise ordinalize_short monetize monetise
                  romanize romanise] => :instance
    end

    # Create numeral with custom configuration
    #
    # @yieldparam [Configuration]
    #
    # @return [Numeral]
    #
    # @api public
    def initialize
      @configuration = Configuration.new
      if block_given?
        yield @configuration
      end
    end

    # Convert a number to a numeral
    #
    # @param [Numeric,String] num
    #   the number to convert
    #
    # @api public
    def numeralize(num, **options)
      case options.delete(:term)
      when /ord/
        ordinalize(num, **options)
      else
        cardinalize(num, **options)
      end
    end

    # Convert a number to a cardinal numeral
    #
    # @example
    #   cardinalize(1234)
    #   # => one thousand, two hundred thirty four
    #
    # @param [Numeric,String] num
    #
    # @return [String]
    #
    # @api public
    def cardinalize(num, **options)
      convert_numeral(num, **options)
    end
    alias :cardinalise :cardinalize

    # Convert a number to an ordinal numeral
    #
    # @example
    #   ordinalize(1234)
    #   # => one thousand, two hundred thirty fourth
    #
    #   ordinalize(12, short: true) # => 12th
    #
    # @param [Numeric,String] num
    #   the number to convert
    #
    # @return [String]
    #
    # @api public
    def ordinalize(num, **options)
      if options[:short]
        ordinalize_short(num)
      else
        decimals = (num.to_i.abs != num.to_f.abs)
        sentence = convert_numeral(num, **options)
        separators = [AND, POINT,
                      options.fetch(:separator, @configuration.separator)].compact

        if decimals && sentence =~ /(\w+) (#{Regexp.union(separators)})/
          last_digits = $1
          separator = $2
          replacement = CARDINAL_TO_ORDINAL[last_digits]
          pattern = /#{last_digits} #{separator}/
          suffix = "#{replacement} #{separator}"
        elsif sentence =~ /(\w+)$/
          last_digits = $1
          replacement = CARDINAL_TO_ORDINAL[last_digits]
          pattern = /#{last_digits}$/
          suffix = replacement
        end

        if replacement
          sentence.sub(pattern, suffix)
        else
          sentence
        end
      end
    end
    alias :ordinalise :ordinalize

    # Convert a number to a short ordinal form
    #
    # @example
    #   ordinalize_short(123) # => 123rd
    #
    # @param [Numeric, String] num
    #   the number to convert
    #
    # @return [String]
    #
    # @api private
    def ordinalize_short(num)
      num_abs = num.to_i.abs

      num.to_i.to_s + (CARDINAL_TO_SHORT_ORDINAL[num_abs % 100] ||
        CARDINAL_TO_SHORT_ORDINAL[num_abs % 10])
    end

    # Convert a number into a monetary numeral
    #
    # @example
    #   monetize(123.45)
    #   # => "one hundred twenty three dollars and forty five cents"
    #
    # @param [Numeric,String] num
    #   the number to convert
    #
    # @return [String]
    #
    # @api public
    def monetize(num, **options)
      sep = options.fetch(:separator, @configuration.separator)
      curr_name = options.fetch(:currency, @configuration.currency)
      n = "%0.2f" % num.to_s
      decimals = (num.to_i.abs != num.to_f.abs)
      sentence = convert_numeral(n, **options.merge(trailing_zeros: true))
      dec_num = n.split(".")[1]
      curr = CURRENCIES[curr_name.to_s.downcase.to_sym]
      separators = [AND, POINT, sep].compact

      if decimals
        regex = /(\w+) (#{Regexp.union(separators)})/
        sentence.sub!(regex, "\\1 #{curr[:units]} \\2")
      else
        sentence += SPACE + (num.to_i == 1 ? curr[:unit] : curr[:units])
      end

      if decimals
        slots = Regexp.union(DECIMAL_SLOTS.map { |slot| slot.chomp('s') })
        regex = /(#{slots})s?/i
        suffix = dec_num.to_i == 1 ? curr[:decimal_unit] : curr[:decimal_units]
        if sentence.sub!(regex, suffix).nil?
          sentence += SPACE + suffix
        end
      end

      sentence
    end
    alias :monetise :monetize

    # Convert a number to a roman numeral
    #
    # @example
    #   romanize(2020) # => "MMXX"
    #
    # @param [Integer] num
    #   the number to convert
    #
    # @return [String]
    #
    # @api public
    def romanize(num)
      n = num.to_i

      if n < 1 || n > 4999
        raise Error, "'#{n}' is out of range"
      end

      CARDINAL_TO_ROMAN.keys.reverse_each.reduce([]) do |word, card|
        while n >= card
          n -= card
          word << CARDINAL_TO_ROMAN[card]
        end
        word
      end.join
    end

    private

    # Convert a number into a numeral
    #
    # @param [Numeric] num
    #   the number to convert to numeral
    # @param [String] delimiter
    #   sets the thousand's delimiter, defaults to `, `
    # @param [String] decimal
    #   the decimal word conversion, defaults to `:fraction`
    # @param [String] separator
    #   sets the separator between the fractional and integer numerals,
    #   defaults to `and` for fractions and `point` for digits
    #
    # @return [String]
    #   the number as numeral
    #
    # @api private
    def convert_numeral(num, **options)
      delimiter = options.fetch(:delimiter, @configuration.delimiter)
      decimal = options.fetch(:decimal, @configuration.decimal)
      separator = options.fetch(:separator, @configuration.separator)

      negative = num.to_i < 0
      n = num.to_i.abs
      decimals = (n != num.to_f.abs)

      sentence = convert_to_words(n).join(delimiter)

      if sentence.empty?
        sentence = ZERO
      end

      if negative
        sentence = NEGATIVE + SPACE + sentence
      end

      if decimals
        sentence = sentence + SPACE +
          (separator.nil? ? (decimal == :fraction ? AND : POINT) : separator) +
          SPACE + convert_decimals(num, **options)
      end

      sentence
    end

    # Convert decimal part to words
    #
    # @param [String] trailing_zeros
    #   whether or not to keep trailing zeros, defaults to `false`
    #
    # @return [String]
    #
    # @api private
    def convert_decimals(num, **options)
      delimiter = options.fetch(:delimiter, @configuration.delimiter)
      decimal = options.fetch(:decimal, @configuration.decimal)
      trailing_zeros = options.fetch(:trailing_zeros, @configuration.trailing_zeros)

      dec_num = num.to_s.split(".")[1]
      dec_num.gsub!(/0+$/, "") unless trailing_zeros

      case decimal
      when :fraction
        unit = DECIMAL_SLOTS[dec_num.to_s.length - 1]
        unit = unit[0...-1] if dec_num.to_i == 1 # strip off 's'
        convert_to_words(dec_num.to_i).join(delimiter) + SPACE + unit
      when :digit
        dec_num.chars.map do |n|
          (v = convert_tens(n.to_i)).empty? ? ZERO : v
        end.join(SPACE)
      else
        raise Error, "Unknown decimal option '#{decimal.inspect}'"
      end
    end

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

        words.insert(0, word.join(SPACE))

        n /= 1000

        break if n.zero?
      end

      words
    end

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
        word << HUNDRED
      end

      if !tens.zero?
        word << convert_tens(tens)
      end

      word.join(SPACE)
    end

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
        word << CARDINALS[tens % 10] unless (tens % 10).zero?
      end

      word.join(SPACE)
    end
  end # Numeral
end # Strings
