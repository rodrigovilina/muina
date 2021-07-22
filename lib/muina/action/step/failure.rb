# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Failures wrap the result into the Failure side of the Result Monad and won't run if result is already set
      class Failure < self
        def call(instance = nil)
          return if instance.instance_variable_get(:@result_set)

          Muina::Failure(Muina::Result() { instance.instance_eval(&step) }.value!)
        end
      end
    end
  end
end
