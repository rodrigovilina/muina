# typed: strict
# frozen_string_literal: true

module Muina
  class Result < Value
    # Left(correct) side of the Result Monad
    class Success < self
      ErrorCalledOnSuccessError = Class.new(Error)
      private_constant :ErrorCalledOnSuccessError

      const :value, T.untyped
      private :value

      def value!
        value
      end

      def error!
        raise ErrorCalledOnSuccessError
      end

      def and_then(&blk)
        blk[value] if blk
        self
      end

      def or_else(&_blk)
        self
      end
    end
  end
end
