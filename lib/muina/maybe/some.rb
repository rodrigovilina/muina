# typed: strict
# frozen_string_literal: true

module Muina
  class Maybe
    # rubocop:disable Metrics/ClassLength

    class Some < self
      class << self
        undef_method :some
        undef_method :none
      end

      Elem = type_member { { upper: Object } }
      ElemT = type_template { { upper: Object } }

      private_class_method(:new)
      sig { params(value: Elem).void }
      def initialize(value) # rubocop:disable Lint/MissingSuper
        @value = value
        freeze
      end

      # (see Maybe#some?)
      sig { override.returns T::Boolean }
      def some?
        true
      end

      sig { override.returns T::Boolean }
      # (see Maybe#none?)
      def none?
        false
      end

      sig { override.returns Elem }
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

      sig { override.returns(T.any(Elem, NilClass)) }
      # (see Maybe#value_or_nil)
      def value_or_nil
        @value
      end

      sig { override.params(_blk: T.untyped).returns(T.self_type) }
      # (see Maybe#and_then)
      def and_then(&_blk)
        yield(@value)
        self
      end

      sig { override.params(_blk: T.untyped).returns(T.self_type) }
      # (see Maybe#or_else)
      def or_else(&_blk)
        self
      end

      sig do
        override.type_parameters(:T)
                .params(
                  _blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:T))
                )
                .returns(T.any(Maybe[Elem], Maybe[T.type_parameter(:T)]))
      end
      # (see Maybe#map)
      def map(&_blk)
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

      sig do
        override.type_parameters(:T)
                .params(
                  _blk: T.proc.params(arg0: Elem).returns(Maybe[T.type_parameter(:T)])
                )
                .returns(T.any(Maybe[Elem], Maybe[T.type_parameter(:T)]))
      end
      # (see Maybe#bind)
      def bind(&_blk)
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
