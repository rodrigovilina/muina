# typed: strict
# frozen_string_literal: true

module Muina
  # Typesafe parameters with extraction from ActionController::Parameters
  class Params
    include T::Props
    include T::Props::Constructor

    # :nocov:
    T::Sig::WithoutRuntime.sig do
      params(params: T.any(T::Hash[T.untyped, T.untyped], ActionController::Parameters))
        .returns(T.attached_class)
    end
    # :nocov:
    def self.extract(params)
      params = ActionController::Parameters.new(params) if params.instance_of?(Hash)
      TypedParams[self].new.extract!(params)
    end
  end
end
