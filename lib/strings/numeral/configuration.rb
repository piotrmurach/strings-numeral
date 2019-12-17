# frozen_string_literal: true

module Strings
  class Numeral
    class Configuration
      # Initialize a configuration
      #
      # @api private
      def initialize
        @delimiter = ", "
        @decimal = :fraction
        @separator = nil
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
    end # Configuration
  end # Numeral
end # Strings
