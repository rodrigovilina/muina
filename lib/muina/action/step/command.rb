# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Commands are meant to run code with side effects and return no value.
      class Command < self
        def call(instance = nil)
          case result = Muina::Result() { instance.instance_eval(&step) }
          when Muina::Result::Success then nil
          else result
          end
        end
      end
    end
  end
end
