# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    @steps = T.let(@steps, T.nilable(T::Array[T.proc.returns(Result)]))
  end
end
