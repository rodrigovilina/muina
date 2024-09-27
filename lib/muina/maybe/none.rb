# typed: strict
# frozen_string_literal: true

module Muina
  class Maybe
    # rubocop:disable Metrics/ClassLength

    class None < self
      class << self
        undef_method :some
        undef_method :none
      end

      Elem = type_member
      ElemT = type_template { { upper: Object } }

      private_class_method(:new)
      sig { void }
      def initialize # rubocop:disable Lint/MissingSuper
        freeze
      end

      sig { override.returns T::Boolean }
      # (see Maybe#some?)
      def some?
        false
      end

      sig { override.returns T::Boolean }
      # (see Maybe#none?)
      def none?
        true
      end

      sig { override.returns Elem }
      # (see Maybe#value!)
      def value!
        raise UnwrappingError
      end

      sig do
        override.type_parameters(:Default)
                .params(default: T.type_parameter(:Default))
                .returns(T.any(Elem, T.type_parameter(:Default)))
      end
      # (see Maybe#value_or)
      def value_or(default)
        default
      end

      sig do
        override.type_parameters(:T)
                .params(_blk: T.proc.returns(T.type_parameter(:T)))
                .returns(T.any(Elem, T.type_parameter(:T)))
      end
      # (see Maybe#value_or_yield)
      def value_or_yield(&_blk)
        yield
      end

      sig { override.returns(T.any(Elem, NilClass)) }
      # (see Maybe#value_or_nil)
      def value_or_nil; end

      sig { override.params(_blk: T.untyped).returns(T.self_type) }
      # (see Maybe#and_then)
      def and_then(&_blk)
        self
      end

      sig { override.params(_blk: T.untyped).returns(T.self_type) }
      # (see Maybe#or_else)
      def or_else(&_blk)
        yield
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
        self
      end

      sig do
        override.type_parameters(:T)
                .params(_blk: T.proc.returns(T.type_parameter(:T)))
                .returns(T.any(Maybe[Elem], Maybe[T.type_parameter(:T)]))
      end
      # (see Maybe#map_none)
      def map_none(&_blk)
        Maybe.return yield
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
        self
      end

      sig do
        override.type_parameters(:T)
                .params(_blk: T.proc.returns(Maybe[T.type_parameter(:T)]))
                .returns(T.any(Maybe[Elem], Maybe[T.type_parameter(:T)]))
      end
      # (see Maybe#bind_none)
      def bind_none(&_blk)
        yield
      end

      sig { override.params(other: T.untyped).returns(T::Boolean) }
      # (see Maybe#==)
      def ==(other)
        other.instance_of?(self.class)
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
