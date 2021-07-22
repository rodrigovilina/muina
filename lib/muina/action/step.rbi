# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    class Step < Value
      const :step, T.untyped

      sig { params(instance: T.untyped).returns(T.untyped) }
      def call(instance)
      end
    end
  end
end
