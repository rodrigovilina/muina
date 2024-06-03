# frozen_string_literal: true

module Muina
  class Result
    private_class_method :new

    def self.success(value)
      Success.__send__(:new, value)
    end

    def self.failure(error)
      Failure.__send__(:new, error)
    end
  end
end
