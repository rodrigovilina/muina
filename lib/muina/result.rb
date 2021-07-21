# typed: strict
# frozen_string_literal: true

module Muina
  # Result Monad
  class Result < Value
    include PrivateCreation

    def self.Null # rubocop:disable Naming/MethodName
      Null.__send__(:new)
    end

    def self.[](success_klass, error_klass)
      Factory.new(success_klass: success_klass, error_klass: error_klass)
    end
  end
end
