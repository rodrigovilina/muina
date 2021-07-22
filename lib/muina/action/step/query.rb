# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Queries are meant to run side effect free code and return the resulting value wrapped in a Result::Success
      class Query < self
        const :name, Symbol

        def call(instance = Object.new)
          case result = Muina::Result() { instance.instance_eval(&step) }
          when Muina::Result::Success then instance.instance_variable_set("@#{name}", result.value!)
          else result
          end
        end
      end
    end
  end
end
