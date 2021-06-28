# typed: strict
# frozen_string_literal: true

module Muina
  # Result Monad
  class Result < Value
    include PrivateCreation

    const :value, T.untyped, default: Unit.instance
    const :error, T.untyped, default: Unit.instance

    private :value, :error

    def self.[](success_klass, error_klass)
      Class.new(self) do
        const :value, T.any(success_klass, Unit), override: true
        const :error, T.any(error_klass, Unit), override: true

        private :value, :error
      end
    end

    def self.success(value)
      new(value: value, error: Unit.instance)
    end

    def self.failure(error)
      new(value: Unit.instance, error: error)
    end

    def value!
      value.tap { raise Error if value.equal?(Unit.instance) }
    end

    def error!
      error.tap { raise Error if error.equal?(Unit.instance) }
    end

    def and_then(&block)
      block[value] if block && error.equal?(Unit.instance)
      self
    end

    def or_else(&block)
      block[error] if block && value.equal?(Unit.instance)
      self
    end
  end
end
