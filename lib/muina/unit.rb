# typed: strict
# frozen_string_literal: true

module Muina
  class Unit
    include Singleton
  end
  UNIT = T.let(Unit.instance, Unit)
  public_constant :UNIT
end
