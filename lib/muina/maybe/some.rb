# typed: true
# frozen_string_literal: true

module Muina
  class Maybe
    # rubocop:disable Metrics/ClassLength

    class Some < self
      Elem = type_member
      ElemT = type_template

      private_class_method(:new)
      def initialize(value) # rubocop:disable Lint/MissingSuper
        @value = value
        freeze
      end

      # (see Maybe#some?)
      sig { override.returns T::Boolean }
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
      sig do
        override.type_parameters(:Default)
                .params(_default: T.type_parameter(:Default))
                .returns(T.any(Elem, T.type_parameter(:Default)))
      end
      def value_or(_default)
        @value
      end

      sig do
        override.type_parameters(:T)
                .params(_blk: T.proc.returns(T.type_parameter(:T)))
                .returns(T.any(Elem, T.type_parameter(:T)))
      end
      # (see Maybe#value_or_yield)
      def value_or_yield(&_blk)
        @value
      end

      # (see Maybe#value_or_nil)
      def value_or_nil
        @value
      end

      sig { override.returns(T.self_type) }
      # (see Maybe#and_then)
      def and_then
        yield(@value)
        self
      end

      sig { override.returns(T.self_type) }
      # (see Maybe#or_else)
      def or_else
        self
      end

      # (see Maybe#map)
      def map
        Maybe.return yield(@value)
      end

      sig do
        override.type_parameters(:T)
                .params(_blk: T.proc.returns(T.type_parameter(:T)))
                .returns(T.any(Maybe[Elem], Maybe[T.type_parameter(:T)]))
      end
      # (see Maybe#map_none)
      def map_none(&_blk)
        self
      end

      # (see Maybe#bind)
      def bind
        yield(@value)
      end

      sig do
        override.type_parameters(:T)
                .params(_blk: T.proc.returns(Maybe[T.type_parameter(:T)]))
                .returns(T.any(Maybe[Elem], Maybe[T.type_parameter(:T)]))
      end
      # (see Maybe#bind_none)
      def bind_none(&_blk)
        self
      end

      sig { override.params(other: T.untyped).returns(T::Boolean) }
      # (see Maybe#==)
      def ==(other)
        self.class == other.class &&
          value! == other.value!
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
