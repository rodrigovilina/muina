# typed: strict
# frozen_string_literal: true

module Muina
  # Immutable Value Object parent class
  class Value
    include T::Props
    include T::Props::Constructor
    include T::Struct::ActsAsComparable

    sig { params(hash: SymbolHash).void }
    def initialize(hash = {})
    end
  end
end
