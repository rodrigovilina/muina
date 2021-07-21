# typed: strict
# frozen_string_literal: true

module Muina
  class Result < Value
    # Right(wrong) side of the Result Monad
    class Failure < self
      ValueCalledOnFailureError = Class.new(Error)
      private_constant :ValueCalledOnFailureError

      const :error, T.untyped
      private :error

      def value!
        raise ValueCalledOnFailureError
      end

      def error!
        error
      end

      def and_then(&_blk)
        self
      end

      def or_else(&blk)
        blk[error] if blk
        self
      end
    end
  end
end
