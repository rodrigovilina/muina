# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Query < Value
      const :name, Symbol
      const :step, T.proc.returns(T.untyped)

      T::Sig::WithoutRuntime.sig { params(instance: Object).returns(T.untyped) }
      def call(instance)
        result = instance.instance_eval(&step)
        instance.instance_variable_set("@#{name}", result)
      end
    end
  end
end
