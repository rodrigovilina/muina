# typed: strict
# frozen_string_literal: true

module Muina
  UntypedHash = T.type_alias { T::Hash[T.untyped, T.untyped] }
end
