# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Final step of a successful Action
      class Result < self
        def call(instance = nil)
          case result = Muina::Result() { instance.instance_eval(&step) }
          when Muina::Result::Success then success(instance, result.value!)
          else result
          end
        end

        private

        def success(instance, value)
          instance.instance_variable_set(:@result_set, true)
          Muina::Success(value)
        end
      end
    end
  end
end
