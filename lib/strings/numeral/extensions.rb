# frozen_string_literal: true

require_relative "../numeral" unless defined?(Strings::Numeral)

module Strings
  class Numeral
    module Extensions
      Methods = Module.new do
        def numeralize(**options)
          Strings::Numeral.numeralize(self, **options)
        end

        def cardinalize(**options)
          Strings::Numeral.cardinalize(self, **options)
        end

        def ordinalize(**options)
          Strings::Numeral.ordinalize(self, **options)
        end

        def ordinalize_short
          Strings::Numeral.ordinalize_short(self)
        end

        def monetize(**options)
          Strings::Numeral.monetize(self, **options)
        end

        def romanize
          Strings::Numeral.romanize(self)
        end
      end

      refine String do
        include Methods
      end

      refine Float do
        include Methods
      end

      refine Integer do
        include Methods
      end
    end # Extensions
  end # Numeral
end # Strings
