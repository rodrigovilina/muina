# typed: strict
# frozen_string_literal: true

module Muina
  class Result < Value
    class Failure < self
      ValueCalledOnFailureError = Class.new(Error)
      private_constant :ValueCalledOnFailureError

      const :error, T.untyped
      private :error

      sig { returns(T.noreturn) }
      def value!; end

      sig { returns(T.untyped) }
      def error!; end

      sig { params(_block: T.untyped).returns(M::Result::Failure) }
      def and_then(&_block); end

      sig { params(block: T.untyped).returns(M::Result::Failure) }
      def or_else(&block); end
    end
  end
end
