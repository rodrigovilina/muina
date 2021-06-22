# typed: strict
# frozen_string_literal: true

module Muina
  # Include this module to make `.allocate` and `.new` private
  module PrivateCreation
    T::Sig::WithoutRuntime.sig { params(klass: Module).void }
    def self.included(klass)
      klass.private_class_method :allocate
      klass.private_class_method :new
    end
  end
end
