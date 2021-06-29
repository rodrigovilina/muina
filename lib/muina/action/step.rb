# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    # Functional step generation
    class Step < Value
      const :step, T.proc.returns(T.untyped)
      const :success, T.untyped
      const :failure, T.untyped

      T::Sig::WithoutRuntime.sig { params(instance: Object).returns(Result) }
      def call(instance = nil)
        result = instance.instance_eval(&step)
        Result[success, failure].success(result)
      rescue Utils.errors_rescue_module(failure) => e
        fail!(e)
      end

      T::Sig::WithoutRuntime.sig { params(error: T.untyped).returns(Result) }
      def fail!(error)
        Result[success, failure].failure(error)
      end
    end
  end
end
