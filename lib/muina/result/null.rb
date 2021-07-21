# typed: strict
# frozen_string_literal: true

module Muina
  class Result < Value
    # Private null type for the Result Monad
    class Null < self
      def value!
        raise Error
      end

      def error!
        raise Error
      end

      def and_then(&_blk)
        self
      end

      def or_else(&_blk)
        self
      end
    end
  end
end
