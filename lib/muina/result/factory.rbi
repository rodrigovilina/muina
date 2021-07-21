# typed: strict
# frozen_string_literal: true

module Muina
  # Result Monad
  class Result < Value
    class Factory < T::Struct
      prop :success_klass, T.untyped
      prop :error_klass,   T.untyped

      sig { params(value: T.untyped).returns(Success) }
      def success(value); end

      sig { params(error: T.untyped).returns(Failure) }
      def failure(error); end

      private

      sig { returns(Class) }
      def success_subclass; end

      sig { returns(Class) }
      def failure_subclass; end

      sig do
        params(klass: T.any(T.class_of(Success), T.class_of(Failure)), symbol: Symbol, sklass: T.untyped).returns(Class)
      end
      def asdf(klass, symbol, sklass)
      end
    end
  end
end
