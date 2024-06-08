# frozen_string_literal: true

module Muina
  class Maybe
    class Some < self
      private_class_method(:new)
      def initialize(value) # rubocop:disable Lint/MissingSuper
        @value = value
        freeze
      end

      def some?
        true
      end

      def none?
        false
      end

      def value!
        @value
      end

      def value_or(_default)
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

      def ==(other)
        self.class == other.class &&
          value! == other.value!
      end
    end
  end
end
