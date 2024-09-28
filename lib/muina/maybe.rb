# typed: strict
# frozen_string_literal: true

module Muina
  # rubocop:disable Metrics/ClassLength

  # Maybe monad
  class Maybe
    extend T::Sig
    extend T::Helpers
    extend T::Generic

    # Raised when trying to unwrap a {None} value
    UnwrappingError = Class.new(Error)

    Elem = type_member { { upper: Object } }
    ElemT = type_template { { upper: Object } }

    class << self
      extend T::Sig

      sig { params(value: ElemT).returns(Maybe[ElemT]) }
      # Returns a {Maybe::Some} wrapping the provided value.
      #
      # @param [Elem] value a value to wrap around a {Some} variant.
      # @return [Some<Elem>]
      def return(value)
        new(value)
      end
      alias some return

      sig { returns(Maybe[NilClass]) }
      # Returns a {Maybe::None}, a safer alternative to +nil+.
      #
      # @return [None]
      def none
        new(nil)
      end
    end

    private_class_method(:new)
    sig { params(value: Elem).void }
    def initialize(value)
      @value = value
      freeze
    end

    sig { returns T::Boolean }
    # Returns +true+ if instance is of the {Some} variant, or +false+ if it is
    # of the {None} variant.
    #
    # @return [true] if instance is of the {Some} variant
    # @return [false] if instance is of the {None} variant
    def some?
      !@value.nil?
    end

    sig { returns T::Boolean }
    # Returns +true+ if instance is of the {None} variant, or +false+ if it is
    # of the {Some} variant.
    #
    # @return [true] if instance is of the {None} variant
    # @return [false] if instance is of the {Some} variant
    def none?
      @value.nil?
    end

    sig { returns Elem }
    # Returns the contained value if instance is of the {Some} variant, or
    # raises {UnwrappingError} if it is of the {None} variant.
    #
    # @return [Elem]
    # @raise [UnwrappingError] if instance is of the {None} variant
    def value!
      raise UnwrappingError if @value.nil?

      @value
    end

    sig do
      type_parameters(:Default)
        .params(default: T.type_parameter(:Default))
        .returns(T.any(Elem, T.type_parameter(:Default)))
    end
    # Returns the contained value if instance is of the {Some} variant, or the
    # provided +default+ value if it is of the {None} variant.
    #
    # @param [Object] default the value to be used if the instance is of the
    #   {None} variant
    # @return [Elem, Object]
    def value_or(default)
      if @value.nil?
        default
      else
        @value
      end
    end

    sig do
      type_parameters(:T).params(_blk: T.proc.returns(T.type_parameter(:T))).returns(T.any(Elem, T.type_parameter(:T)))
    end
    # Returns the contained value if instance is of the {Some} variant, or runs
    # the provided block and returns its result if it is of the {None} variant.
    #
    # @yieldreturn [Object]
    # @return [Elem, yield]
    def value_or_yield(&_blk)
      if @value.nil?
        yield
      else
        @value
      end
    end

    sig { returns(T.nilable(Elem)) }
    # Returns the contained value if instance is of the {Some} variant, or +nil+
    # if it is of the {None} variant.
    #
    # @return [Elem, nil]
    def value_or_nil
      @value
    end

    sig { params(_blk: T.untyped).returns(T.self_type) }
    # Runs the provided block only if instance is of the {Some} variant,
    # yielding the contained value.
    # Always returns +self+.
    #
    # @yieldparam value [Elem] the contained value is passed to the block
    # @return [self]
    def and_then(&_blk)
      unless @value.nil?
        yield(@value)
      end

      self
    end

    sig { params(_blk: T.untyped).returns(T.self_type) }
    # Runs the provided block only if instance is of the {None} variant,
    # yielding no value to the block.
    # Always returns +self+.
    #
    # @yield []
    # @return [self]
    def or_else(&_blk)
      if @value.nil?
        yield
      end

      self
    end

    sig do
      type_parameters(:T)
        .params(_blk: T.proc.params(arg0: Elem).returns(T.type_parameter(:T)))
        .returns(T.any(Maybe[Elem], Maybe[T.all(T.type_parameter(:T), Object)]))
    end
    # If instance is of the {Some} variant, it passes the contained value to the
    # block and returns a new {Some} instance containing the return value of the
    # block; if instance is of the {None} variant, it returns itself.
    #
    # @yieldparam value [Elem] the contained value is passed to the block
    # @yieldreturn [Object]
    # @return [Maybe<yield>, None]
    def map(&_blk)
      if @value.nil?
        self
      else
        Maybe.return yield(@value)
      end
    end

    sig do
      type_parameters(:T)
        .params(_blk: T.proc.returns(T.type_parameter(:T)))
        .returns(T.any(Maybe[Elem], Maybe[T.all(T.type_parameter(:T), Object)]))
    end
    # If instance is of the {Some} variant, it returns itself; if instance is of
    # the {None} variant it runs the block and returns a new {Some} instance
    # containing the return value of the block.
    #
    # @yield []
    # @yieldreturn [Object]
    # @return [Maybe<yield>, self]
    def map_none(&_blk)
      if @value.nil?
        Maybe.return yield
      else
        self
      end
    end

    sig do
      type_parameters(:T)
        .params(
          _blk: T.proc.params(arg0: Elem).returns(Maybe[T.all(T.type_parameter(:T), Object)])
        )
        .returns(T.any(Maybe[Elem], Maybe[T.all(T.type_parameter(:T), Object)]))
    end
    # If instance is of the {Some} variant, it yields the contained value to the
    # block and it returns the return value of the block; if it is of the {None}
    # variant, it returns itself.
    #
    # @yieldparam value [Elem] the contained value is passed to the block
    # @yieldreturn [Maybe]
    # @return [Maybe]
    def bind(&_blk)
      if @value.nil?
        self
      else
        yield(@value)
      end
    end

    sig do
      type_parameters(:T)
        .params(_blk: T.proc.returns(Maybe[T.all(T.type_parameter(:T), Object)]))
        .returns(T.any(Maybe[Elem], Maybe[T.all(T.type_parameter(:T), Object)]))
    end
    # If instance is of the {None} variant, it runs the provided block and it
    # returns its return value; if it is of the {Some} variant, it returns
    # itself.
    #
    # @yield []
    # @yieldreturn [Maybe]
    # @return [Maybe]
    def bind_none(&_blk)
      if @value.nil?
        yield
      else
        self
      end
    end

    sig { params(other: T.untyped).returns(T::Boolean) }
    # Returns +true+ if both instances are of the same variant, and the
    # contained values are equal in the case of {Some}.
    #
    # @param [Maybe<Elem>] other
    # @return [Boolean]
    def ==(other)
      self.class == other.class && value_or_nil == other.value_or_nil
    end
  end
  # rubocop:enable Metrics/ClassLength
end
