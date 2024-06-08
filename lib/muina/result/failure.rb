# frozen_string_literal: true

module Muina
  class Result
    class Failure < self
      def initialize(error) # rubocop:disable Lint/MissingSuper
        @error = error
        freeze
      end

      def value!
        raise
      end

      def error!
        @error
      end
    end
  end
end
