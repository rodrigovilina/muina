# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Queries are meant to run side effect free code and return the resulting value wrapped in a Result::Success
      class Query < self
        const :name, Symbol

        def call(action = Object.new) # rubocop:disable Metrics/MethodLength
          return if action.instance_variable_get(:@__failure__)

          case result = Muina::Result() { action.instance_eval(&step) }
          when Muina::Result::Success then success(action, result)
          when Muina::Result::Failure then failure(action, result)
          # :nocov:
          else T.absurd(result)
            # :nocov:
          end
        end

        private

        def success(action, result)
          action.instance_variable_set("@#{name}", result.value!)
        end

        def failure(action, result)
          action.instance_variable_set(:@__failure__, result)
        end
      end
    end
  end
end
