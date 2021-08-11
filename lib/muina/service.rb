# typed: strict
# frozen_string_literal: true

module Muina
  # Simple Service Object compatible with MiniService::Base
  class Service
    include T::Props
    include T::Props::Constructor
    include PrivateCreation

    def self.inherited(subklass) # rubocop:disable Metrics/MethodLength
      super
      # :nocov:
      TracePoint.trace(:end) do |t|
        if subklass < self && !subklass.instance_methods(false).include?(:perform) # rubocop:disable Style/MissingElse
          Logger.new($stdout).fatal "#{subklass}#perfrom is not implemented"
        end
        t.disable
      end
      # :nocov:
    end

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
