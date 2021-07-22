# typed: strict
# frozen_string_literal: true

module Muina
  # Include this module to make `.allocate` and `.new` private
  module PrivateCreation
    sig { params(klass: Class).void }
    def self.included(klass)
    end
  end
end
