# frozen_string_literal: true

module Muina
  class Maybe
    def self.return(value)
      Some.__send__(:new, value)
    end

    def self.none
      None.__send__(:new)
    end
  end
end
