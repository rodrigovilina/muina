# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      class Query < self
        const :name, Symbol

        sig { params(instance: T.untyped).returns(T.untyped) }
        def call(instance = Object.new)
        end
      end
    end
  end
end
