# typed: strict
# frozen_string_literal: true

module Muina
  # Typesafe parameters with extraction from ActionController::Parameters
  class Params
    include T::Props
    include T::Props::Constructor

    T::Sig::WithoutRuntime.sig { params(params: Parameters).returns(T.attached_class) }
    def self.extract(params)
      params = ActionController::Parameters.new(params) if params.instance_of?(Hash)
      TypedParams[self].new.extract!(params)
    end
  end
end
