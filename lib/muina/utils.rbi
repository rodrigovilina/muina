# typed: strict
# frozen_string_literal: true

module Muina
  # Casting utils
  module Utils
    sig { params(errors: T.untyped).returns(T.untyped) }
    def self.cast_to_errors(*errors)
    end

    sig { params(type: T.untyped).returns(T.untyped) }
    def self.cast_to_error(type)
    end

    sig { params(error: T.untyped).returns(T.untyped) }
    def self.cast_union_to_errors(error)
    end

    sig { params(failure_klass: T.untyped).returns(T.untyped) }
    def self.errors_rescue_module(failure_klass)
    end

    sig { params(error: T.untyped).returns(T.untyped) }
    def self.flatten_union(error)
    end
  end
end
