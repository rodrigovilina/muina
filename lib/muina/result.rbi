# typed: strict
# frozen_string_literal: true

module Muina
  Unit = Class.new do
    include Singleton
  end
  # Result Monad
  class Result < Value
    def initialize(hash = {})
      @value = T.let(@value, T.untyped)
      @error = T.let(@error, T.untyped)
    end
  end
end
