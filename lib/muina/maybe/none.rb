# frozen_string_literal: true

module Muina
  class Maybe
    class None < self
      private_class_method(:new)
      def initialize # rubocop:disable Lint/MissingSuper
        freeze
      end

      def some?
        false
      end

      def none?
        true
      end

      def value!
        raise
      end

      def value_or(default)
        default
      end

      def value_or_yield
        yield
      end

      def value_or_nil
        nil
      end

      def and_then
        self
      end

      def or_else
        yield
        self
      end

      def map
        self
      end

      def map_none
        Maybe.return yield
      end

      def bind
        self
      end

      def bind_none
        yield
      end

      def ==(other)
        self.class == other.class
      end
    end
  end
end
