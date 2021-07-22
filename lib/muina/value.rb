# typed: strict
# frozen_string_literal: true

module Muina
  # Immutable Value Object parent class
  class Value
    include T::Props
    include T::Props::Constructor
    include T::Struct::ActsAsComparable

    def initialize(hash = {})
      super(hash)
      freeze
    end
  end
end
