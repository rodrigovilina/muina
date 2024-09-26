# frozen_string_literal: true

module Muina
  # @abstract
  # @param [Elem] elem the type of element maybe contained inside the monad
  class Maybe
    # Raised when trying to unwrap a {None} value
    UnwrappingError = Class.new(Error)

    class << self
      # Returns a {Maybe::Some} wrapping the provided value.
      #
      # @param [Elem] value a value to wrap around a {Some} variant.
      # @return [Some<Elem>]
      def return(value)
        Some.__send__(:new, value)
      end
      alias some return

      # Returns a {Maybe::None}, a safer alternative to +nil+.
      #
      # @return [None]
      def none
        None.__send__(:new)
      end
    end

    # Returns +true+ if instance is of the {Some} variant, or +false+ if it is
    # of the {None} variant.
    #
    # @return [true] if instance is of the {Some} variant
    # @return [false] if instance is of the {None} variant
    def some?
    end

    # Returns +true+ if instance is of the {None} variant, or +false+ if it is
    # of the {Some} variant.
    #
    # @return [true] if instance is of the {None} variant
    # @return [false] if instance is of the {Some} variant
    def none?
    end

    # Returns the contained value if instance is of the {Some} variant, or
    # raises {UnwrappingError} if it is of the {None} variant.
    #
    # @return [Elem]
    # @raise [UnwrappingError] if instance is of the {None} variant
    def value!
    end

    # Returns the contained value if instance is of the {Some} variant, or the
    # provided +default+ value if it is of the {None} variant.
    #
    # @param [Object] default the value to be used if the instance is of the
    #   {None} variant
    # @return [Elem, Object]
    def value_or(default)
    end

    # Returns the contained value if instance is of the {Some} variant, or runs
    # the provided block and returns its result if it is of the {None} variant.
    #
    # @yieldreturn [Object]
    # @return [Elem, yield]
    def value_or_yield
    end

    # Returns the contained value if instance is of the {Some} variant, or +nil+
    # if it is of the {None} variant.
    #
    # @return [Elem, nil]
    def value_or_nil
    end

    # Runs the provided block only if instance is of the {Some} variant,
    # yielding the contained value.
    # Always returns +self+.
    #
    # @yieldparam value [Elem] the contained value is passed to the block
    # @return [self]
    def and_then
    end

    # Runs the provided block only if instance is of the {None} variant,
    # yielding no value to the block.
    # Always returns +self+.
    #
    # @yield []
    # @return [self]
    def or_else
    end

    # If instance is of the {Some} variant, it passes the contained value to the
    # block and returns a new {Some} instance containing the return value of the
    # block; if instance is of the {None} variant, it returns itself.
    #
    # @yieldparam value [Elem] the contained value is passed to the block
    # @yieldreturn [Object]
    # @return [Maybe<yield>, None]
    def map
    end

    # If instance is of the {Some} variant, it returns itself; if instance is of
    # the {None} variant it runs the block and returns a new {Some} instance
    # containing the return value of the block.
    #
    # @yield []
    # @yieldreturn [Object]
    # @return [Maybe<yield>, self]
    def map_none
    end

    # If instance is of the {Some} variant, it yields the contained value to the
    # block and it returns the return value of the block; if it is of the {None}
    # variant, it returns itself.
    #
    # @yieldparam value [Elem] the contained value is passed to the block
    # @yieldreturn [Maybe]
    # @return [Maybe]
    def bind
    end

    # If instance is of the {None} variant, it runs the provided block and it
    # returns its return value; if it is of the {Some} variant, it returns
    # itself.
    #
    # @yield []
    # @yieldreturn [Maybe]
    # @return [Maybe]
    def bind_none
    end

    # Returns +true+ if both instances are of the same variant, and the
    # contained values are equal in the case of {Some}.
    #
    # @param [Maybe<Elem>] other
    # @return [Boolean]
    def ==(other)
    end
  end
end

require_relative 'maybe/some'
require_relative 'maybe/none'
