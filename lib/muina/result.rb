# typed: strict
# frozen_string_literal: true

module Muina
  Unit = Class.new do
    include Singleton
  end
  # Result Monad
  class Result < Value
    include PrivateCreation

    const :value, T.untyped
    const :error, T.untyped

    T::Sig::WithoutRuntime.sig { params(success_klass: T.untyped, error_klass: T.untyped).returns(T.untyped) }
    def self.[](success_klass, error_klass) # rubocop:disable Metrics/MethodLength
      Class.new(self) do
        const :value, T.any(success_klass, Unit), override: true
        const :error, T.any(error_klass, Unit), override: true

        def value
          super().tap { |value| raise Error if value.equal?(Unit.instance) }
        end

        def error
          super().tap { |error| raise Error if error.equal?(Unit.instance) }
        end
      end
    end

    T::Sig::WithoutRuntime.sig { params(value: T.untyped).returns(T.attached_class) }
    def self.success(value)
      new(value: value, error: Unit.instance)
    end

    T::Sig::WithoutRuntime.sig { params(error: T.untyped).returns(T.attached_class) }
    def self.failure(error)
      new(value: Unit.instance, error: error)
    end
  end
end
