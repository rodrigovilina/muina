# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Commands are meant to run code with side effects and return no value.
      class Command < self
        def call(action = Object.new) # rubocop:disable Metrics/MethodLength
          return if action.instance_variable_get(:@__failure__)

          case result = Muina::Result() { action.instance_eval(&step) }
          when Muina::Result::Success then success
          when Muina::Result::Failure then failure(action, result)
          # :nocov:
          else T.absurd(result)
            # :nocov:
          end
        end

        private

        def success
          # noop
        end

        def failure(action, result)
          action.instance_variable_set(:@__failure__, result)
        end
      end
    end
  end
end
