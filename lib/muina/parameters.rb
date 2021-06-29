# typed: strict
# frozen_string_literal: true

module Muina
  Parameters = T.type_alias { T.any(UntypedHash, ActionController::Parameters) }
  public_constant :Parameters
end
