# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      class Command < self
        sig { params(instance: T.untyped).returns(T.untyped) }
        def call(instance = nil)
        end
      end
    end
  end
end
