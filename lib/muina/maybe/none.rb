# frozen_string_literal: true

module Muina
  class Maybe
    class None < self
      private_class_method(:new)
      def initialize # rubocop:disable Lint/MissingSuper
        freeze
      end

      # (see Maybe#some?)
      def some?
        false
      end

      # (see Maybe#none?)
      def none?
        true
      end

      # (see Maybe#value!)
      def value!
        raise UnwrappingError
      end

      # (see Maybe#value_or)
      def value_or(default)
        default
      end

      # (see Maybe#value_or_yield)
      def value_or_yield
        yield
      end

      # (see Maybe#value_or_nil)
      # def value_or_nil
      #   super
      # end

      # (see Maybe#and_then)
      def and_then
        self
      end

      # (see Maybe#or_else)
      def or_else
        yield
        self
      end

      # (see Maybe#map)
      def map
        self
      end

      # (see Maybe#map_none)
      def map_none
        Maybe.return yield
      end

      # (see Maybe#bind)
      def bind
        self
      end

      # (see Maybe#bind_none)
      def bind_none
        yield
      end

      # (see Maybe#==)
      def ==(other)
        self.class == other.class
      end
    end
  end
end
