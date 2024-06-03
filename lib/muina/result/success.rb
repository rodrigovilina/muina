# frozen_string_literal: true

module Muina
  class Result
    class Success < self
      def initialize(value)
        @value = value
        freeze
      end

      def value!
        @value
      end

      def error!
        raise
      end
    end
  end
end
