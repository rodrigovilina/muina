# frozen_string_literal: true

module Muina
  class Maybe
    UnwrappingError = Class.new(Error)

    class << self
      def return(value)
        Some.__send__(:new, value)
      end
      alias some return

      def none
        None.__send__(:new)
      end
    end
  end
end

require_relative 'maybe/some'
require_relative 'maybe/none'
