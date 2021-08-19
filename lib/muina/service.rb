# typed: strict
# frozen_string_literal: true

module Muina
  # Simple Service Object compatible with MiniService::Base
  class Service
    include T::Props
    include T::Props::Constructor
    include PrivateCreation

    def self.call(hash = {})
      new(hash).__send__(:perform)
    end
    class << self; alias_method :[], :call; end

    def self.arguments(*args, **opts)
      args.each { |arg| const arg, T.untyped }
      opts.each { |key, value| const key, T.untyped, default: value }
    end

    def perform
      raise NotImplementedError, "Please implement the #{self.class}#perform method"
    end
  end
end
