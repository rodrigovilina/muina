# typed: strict
# frozen_string_literal: true

module Muina
  # Feature implementation with typesafe params and wrapped up failures
  class Action
    @steps = T.let(@steps, T.nilable(T::Array[T.untyped]))
    @success = T.let(@success, Object)
    @failure = T.let(@failure, Object)
  end
end
