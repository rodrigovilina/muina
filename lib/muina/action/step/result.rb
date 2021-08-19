# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      # Final step of a successful Action
      class Result < self
        # Eval the step and save the result
        class Caller
          # Save result on succesful side
          class Successful < self
            def initialize(action, result)
              super()
              @action = action
              @result = result
            end

            def call
              @action.instance_variable_set(:@__result__, @result)
            end
          end

          # Save result on failure side
          class Failed < self
            def initialize(action, result)
              super()
              @action = action
              @result = result
            end

            def call
              @action.instance_variable_set(:@__failure__, @result)
            end
          end

          def self.for(action, step)
            case result = Muina::Result() { action.instance_eval(&step) }
            when Muina::Result::Success then Caller::Successful.new(action, result)
            when Muina::Result::Failure then Caller::Failed.new(action, result)
            # :nocov:
            else T.absurd(result)
              # :nocov:
            end
          end
        end

        def call(action = Object.new)
          return if action.instance_variable_get(:@__failure__)

          Caller.for(action, step).call
        end
      end
    end
  end
end
