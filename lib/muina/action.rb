# typed: strict
# frozen_string_literal: true

module Muina
  # Feature implementation with typesafe params and wrapped up failures
  class Action
    include T::Props
    include T::Props::Constructor

    T::Sig::WithoutRuntime.sig { returns(T::Array[T.untyped]) }
    def self.steps
      @steps ||= []
    end

    T::Sig::WithoutRuntime.sig { returns(T.untyped) }
    def self.success
      @success ||= T.let(T.untyped, Object)
    end

    T::Sig::WithoutRuntime.sig { returns(T.untyped) }
    def self.failure
      @failure ||= T.let(T.untyped, Object)
    end

    T::Sig::WithoutRuntime.sig { params(hash: T::Hash[Symbol, T.untyped]).returns(T.untyped) }
    def self.call(hash = {})
      new(hash).perform
    end

    T::Sig::WithoutRuntime.sig do
      params(name: Symbol, step: T.proc.returns(T.untyped)).returns(T::Array[T.untyped])
    end
    def self.query(name, &step)
      const name, T.untyped
      steps << Query.new(name: name, step: step)
    end

    T::Sig::WithoutRuntime.sig { params(step: T.untyped).returns(T::Array[T.untyped]) }
    def self.result(&step)
      steps << Step.new(step: step, success: success, failure: failure)
    end

    T::Sig::WithoutRuntime.sig { returns(T.untyped) }
    def perform
      self.class.steps.map { |step| step.call(self) }.last
    end
  end
end
