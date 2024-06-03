# frozen_string_literal: true

module Muina
  class Maybe
    class Some < self
      def initialize(value)
        @value = value
        freeze
      end
      private_class_method(:new)

      def some?
        true
      end

      def none?
        false
      end

      def value!
        @value
      end

      def value_or(default)
        @value
      end

      def value_or_yield
        @value
      end

      def value_or_nil
        @value
      end

      def and_then
        yield(@value)
        self
      end

      def or_else
        self
      end

      def map
        Maybe.return yield(@value)
      end
      
      def map_none
        self
      end

      def bind
        yield(@value)
      end

      def bind_none
        self
      end
    end
  end
end
