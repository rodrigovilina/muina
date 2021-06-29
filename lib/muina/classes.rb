# typed: strict
# frozen_string_literal: true

module Muina
  Classes = T.type_alias { T.any(Class, T::Array[Class]) }
  public_constant :Classes
end
