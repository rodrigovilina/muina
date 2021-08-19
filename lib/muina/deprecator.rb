# typed: strict
# frozen_string_literal: true

module Muina
  # Method deprecator
  class Deprecator
    class Error < StandardError; end

    @instances = T.let(Hash.new { |h, k| h[k] = {} }, T::Hash[String, T.untyped])

    class << self
      sig { returns(T::Hash[String, T.untyped]) }
      attr_reader :instances
    end

    sig { returns(T::Hash[String, T.untyped]) }
    def self.renew_instances
      @instances = Hash.new { |h, k| h[k] = {} }
    end

    sig { params(name: String).void }
    def self.deactivate(name)
      instances[name][:raise] = false
    end

    sig { params(name: String).void }
    def self.activate(name)
      instances[name][:raise] = true
    end

    sig { params(name: String).returns(T.nilable(T::Boolean)) }
    def self.raise?(name)
      instances[name][:raise]
    end

    sig { params(old: String, new: T.nilable(String), logger: T.untyped, raise: T::Boolean).void }
    def self.call(old:, new: nil, logger: default_logger, raise: false)
      new(new: new, old: old, logger: logger, raise: raise).perform
    end

    sig { returns(Logger) }
    def self.default_logger
      Logger.new($stdout)
    end

    sig { params(old: T.untyped, logger: T.untyped, new: T.untyped, raise: T.untyped).void }
    def initialize(old:, logger:, new: nil, raise: false)
      @new = T.let(new, T.nilable(String))
      @old = T.let(old, String)
      @logger = T.let(logger, T.untyped)
      @raise = T.let(raise, T::Boolean)
    end

    sig { returns(T.nilable(String)) }
    attr_reader :new

    sig { returns(String) }
    attr_reader :old

    sig { returns(T.untyped) }
    attr_reader :logger

    sig { returns(T::Boolean) }
    attr_reader :raise

    sig { returns(T::Boolean) }
    def raise?() @raise end # rubocop:disable Style/SingleLineMethods

    sig { returns(NilClass) }
    def perform # rubocop:disable Metrics/MethodLength
      logger.warn message
      case conf = self.class.raise?(old)
      when nil then Kernel.raise Muina::Deprecator::Error, message if raise?
      when true then Kernel.raise Muina::Deprecator::Error, message
      when false then nil
      # :nocov:
      else T.absurd(conf)
        # :nocov:
      end
    end

    private

    sig { returns(String) }
    def message
      if new
        "Method: #{old} has been DEPRECATED, please use #{new} instead"
      else
        "Method: #{old} has been DEPRECATED with no replacement"
      end
    end
  end
end
