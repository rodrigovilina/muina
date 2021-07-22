# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      class Result < self
        sig { params(instance: T.untyped).returns(T.untyped) }
        def call(instance = nil)
        end

        private

        sig { params(instance: T.untyped, value: T.untyped).returns(T.untyped) }
        def success(instance, value)
        end
      end
    end
  end
end
