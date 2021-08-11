# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Failures wrap the result into the Failure side of the Result Monad and won't run if result is already set
      class Failure < self
        def call(action = nil)
          return if action.instance_variable_get(:@__result__) || !action.instance_variable_get(:@__failure__)

          result = Muina::Failure(Muina::Result() { action.instance_eval(&step) }.value!)
          action.instance_variable_set(:@__failure__, result)
        end
      end
    end
  end
end
