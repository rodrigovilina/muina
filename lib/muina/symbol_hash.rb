# typed: strict
# frozen_string_literal: true

module Muina
  SymbolHash = T.type_alias { T::Hash[Symbol, T.untyped] }
  public_constant :SymbolHash
end
