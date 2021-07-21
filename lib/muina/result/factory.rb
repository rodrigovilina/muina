# typed: strict
# frozen_string_literal: true

module Muina
  # Result Monad
  class Result < Value
    # Typed Results Factory.
    class Factory < T::Struct
      prop :success_klass, T.any(Classes, T::Types::Base)
      prop :error_klass,   T.any(Classes, T::Types::Base)

      def success(value)
        success_subclass.__send__(:new, value: value)
      end

      def failure(error)
        failure_subclass.__send__(:new, error: error)
      end

      private

      def success_subclass
        klass_factory(Success, :value, success_klass)
      end

      def failure_subclass
        klass_factory(Failure, :error, error_klass)
      end

      sig do
        params(klass: T.any(T.class_of(Success), T.class_of(Failure)), symbol: Symbol, sklass: T.untyped).returns(Class)
      end
      def klass_factory(klass, symbol, sklass)
        iklass = T.unsafe(Class.new(klass)) # rubocop:disable Sorbet/ForbidTUnsafe
        iklass.const symbol, sklass, override: true
        iklass.__send__(:private, symbol)
      end
    end
  end
end
