# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    # Cast params to ActionController::Parameters
    module ParamsFactory
      def self.build(params)
        if params.instance_of?(Hash)
          ActionController::Parameters.new(params)
        else
          params
        end
      end
    end
  end
end
