# typed: strict
# frozen_string_literal: true

module Muina
  # Typesafe parameters with extraction from ActionController::Parameters
  class Params
    include T::Props
    include T::Props::Constructor

    sig { params(params: Parameters).returns(T.attached_class) }
    def self.extract(params)
    end
  end
end
