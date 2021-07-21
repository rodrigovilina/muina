# typed: strict
# frozen_string_literal: true

module Muina
  class Result < Value
    class Success < self
      ErrorCalledOnSuccessError = Class.new(Error)
      private_constant :ErrorCalledOnSuccessError

      const :value, T.untyped
      private :value

      sig { returns(T.untyped) }
      def value!
      end

      sig { returns(T.noreturn) }
      def error!
      end

      sig { params(block: T.untyped).returns(T.untyped) }
      def and_then(&block)
      end

      sig { params(_block: T.untyped).returns(T.untyped) }
      def or_else(&_block)
      end
    end
  end
end
