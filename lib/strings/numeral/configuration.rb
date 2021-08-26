# frozen_string_literal: true

module Strings
  class Numeral
    class Configuration
      # Initialize a configuration
      #
      # @api private
      def initialize
        @currency = :usd
        @delimiter = ", "
        @decimal = :fraction
        @separator = nil
        @trailing_zeros = false
      end

      # Update current configuration
      #
      # @api public
      def update(currency: nil, delimiter: nil, separator: nil, decimal: nil,
                 trailing_zeros: nil)
        @currency = currency if currency
        @delimiter = delimiter if delimiter
        @separator = separator if separator
        @decimal = decimal if decimal
        @trailing_zeros = trailing_zeros if trailing_zeros
      end

      # The currency words to use when converting
      #
      # @example
      #   numeral = Strings::Numeral.new
      #   numeral.configure do |config|
      #     config.currency "PLN"
      #   end
      #
      # @param [String] value
      #
      # @api public
      def currency(value = (not_set = true))
        if not_set
          @currency
        else
          @currency = value
        end
      end

      # The thousands delimiter
      #
      # @example
      #   numeral = Strings::Numeral.new
      #   numeral.configure do |config|
      #     config.delimiter "; "
      #   end
      #
      # @param [String] value
      #
      # @api public
      def delimiter(value = (not_set = true))
        if not_set
          @delimiter
        else
          @delimiter = value
        end
      end

      # The integer and fractional parts separator
      #
      # @example
      #   numeral = Strings::Numeral.new
      #   numeral.configure do |config|
      #     config.separator "dot"
      #   end
      #
      # @param [String] value
      #
      # @api public
      def separator(value = (not_set = true))
        if not_set
          @separator
        else
          @separator = value
        end
      end

      # The format for fractional part of a number
      #
      # @example
      #   numeral = Strings::Numeral.new
      #   numeral.configure do |config|
      #     config.decimal :digit
      #   end
      #
      # @param [Symbol] value
      #
      # @api public
      def decimal(value = (not_set = true))
        if not_set
          @decimal
        else
          @decimal = value
        end
      end

      # Whether or not to keep trailing zeros
      #
      # @example
      #   numeral = Strings::Numeral.new
      #   numeral.configure do |config|
      #     config.trailing_zeros true
      #   end
      #
      # @param [Boolean] value
      #
      # @api public
      def trailing_zeros(value = (not_set = true))
        if not_set
          @trailing_zeros
        else
          @trailing_zeros = value
        end
      end
    end # Configuration
  end # Numeral
end # Strings
