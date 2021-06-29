# typed: strict
# frozen_string_literal: true

module Muina
  UntypedArray = T.type_alias { T::Array[T.untyped] }
  public_constant :UntypedArray
end
