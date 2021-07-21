# typed: strict
# frozen_string_literal: true

module Muina
  class Result < Value
    class Null < self
      sig { returns(T.noreturn) }
      def value!
      end

      sig { returns(T.noreturn) }
      def error!
      end

      sig { returns(Null) }
      def and_then(&_block)
      end

      sig { returns(Null) }
      def or_else(&_block)
      end
    end
  end
end
