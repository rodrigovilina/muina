# typed: strict
# frozen_string_literal: true

module Muina
  # Result Monad
  class Result < Value
    include PrivateCreation

    sig { returns(M::Result::Null) }
    def self.Null; end

    sig { params(success_klass: T.untyped, error_klass: T.untyped).returns(T.untyped) }
    def self.[](success_klass, error_klass); end

    sig { returns(T.untyped) }
    def value!
    end
  end
end
