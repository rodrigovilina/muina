# frozen_string_literal: true

module Muina
  class Maybe
    class Some < self
      private_class_method(:new)
      def initialize(value) # rubocop:disable Lint/MissingSuper 
        @value = value
        freeze
      end

      # (see Maybe#some?)
      def some?
        true
      end

      # (see Maybe#none?)
      def none?
        false
      end

      # (see Maybe#value!)
      def value!
        @value
      end

      # (see Maybe#value_or)
      def value_or(_default)
        @value
      end

      # (see Maybe#value_or_yield)
      def value_or_yield
        @value
      end

      # (see Maybe#value_or_nil)
      def value_or_nil
        @value
      end

      # (see Maybe#and_then)
      def and_then
        yield(@value)
        self
      end

      # (see Maybe#or_else)
      def or_else
        self
      end

      # (see Maybe#map)
      def map
        Maybe.return yield(@value)
      end

      # (see Maybe#map_none)
      def map_none
        self
      end

      # (see Maybe#bind)
      def bind
        yield(@value)
      end

      # (see Maybe#bind_none)
      def bind_none
        self
      end

      # (see Maybe#==)
      def ==(other)
        self.class == other.class &&
          value! == other.value!
      end
    end
  end
end
