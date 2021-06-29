# typed: strict
# frozen_string_literal: true

module Muina
  # Feature implementation with typesafe params and wrapped up failures
  class Action < Params
    include T::Props
    include T::Props::Constructor

    T::Sig::WithoutRuntime.sig { returns(T::Array[T.any(Query, Step)]) }
    def self.steps
      @steps ||= []
    end

    def self.success
      @success ||= T.untyped
    end

    def self.failure
      @failure ||= T.untyped
    end

    T::Sig::WithoutRuntime.sig { returns(T::Boolean) }
    def self.result_set
      @result_set ||= false
    end

    T::Sig::WithoutRuntime.sig { params(hash: SymbolHash).returns(T.untyped) }
    def self.call(hash = {})
      extract(hash).perform
    end

    T::Sig::WithoutRuntime.sig { params(name: Symbol, step: T.untyped).void }
    def self.query(name, &step)
      const name, T.untyped
      steps << Query.new(name: name, step: step)
    end

    T::Sig::WithoutRuntime.sig { params(step: T.untyped).void }
    def self.result(&step)
      raise Error if result_set

      steps << Step.new(step: step, success: success, failure: failure)
      @result_set = true
    end

    T::Sig::WithoutRuntime.sig { returns(Result) }
    def perform
      self.class.steps.map { |step| step.call(self) }.last || Result.success(UNIT)
    end
  end
end
