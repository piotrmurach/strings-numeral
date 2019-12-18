# frozen_string_literal: true

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

        def ordinalize_short(**options)
          Strings::Numeral.ordinalize_short(self, **options)
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
