# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    module ParamsFactory
      sig { params(params: T.untyped).returns(T.untyped) }
      def self.build(params)
      end
    end
  end
end
