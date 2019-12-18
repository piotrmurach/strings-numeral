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

      def currency(value = (not_set = true))
        if not_set
          @currency
        else
          @currency = value
        end
      end

      def delimiter(value = (not_set = true))
        if not_set
          @delimiter
        else
          @delimiter = value
        end
      end

      def separator(value = (not_set = true))
        if not_set
          @separator
        else
          @separator = value
        end
      end

      def decimal(value = (not_set = true))
        if not_set
          @decimal
        else
          @decimal = value
        end
      end

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
