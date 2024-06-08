# frozen_string_literal: true

module Muina
  class Maybe
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
