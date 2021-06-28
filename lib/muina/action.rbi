# typed: strict
# frozen_string_literal: true

module Muina
  # Feature implementation with typesafe params and wrapped up failures
  class Action
    @failure    = T.let(@failure,    Object)
    @result_set = T.let(@result_set, T::Boolean)
    @steps      = T.let(@steps,      T.nilable(T::Array[T.untyped]))
    @success    = T.let(@success,    Object)
  end
end
