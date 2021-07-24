# typed: strict
# frozen_string_literal: true

module Muina
  class Error < StandardError; end

  sig { params(value: T.untyped).returns(M::Result::Success) }
  def self.Success(value); end

  sig { params(error: T.untyped).returns(M::Result::Failure) }
  def self.Failure(error); end

  sig { params(blk: T.untyped).returns(M::Result) }
  def self.Result(&blk); end

  class Action
    include T::Props
    include T::Props::Constructor

    class DoubleResultError < Error
    end

    @steps      = T.let(@steps, T.nilable(T::Array[M::Action::Step]))
    @parameters = T.let(@parameters, T.untyped)
    @result_set = T.let(@result_set, T::Boolean)

    sig { returns(T::Array[M::Action::Step]) }
    def self.steps; end

    sig { params(params: T.untyped).returns(T.untyped) }
    def self.extract(params); end

    sig { params(blk: T.untyped).returns(T.untyped) }
    def self.result(&blk); end

    sig { params(blk: T.untyped).returns(T.untyped) }
    def self.failure(&blk); end

    sig { params(_name: T.untyped, blk: T.untyped).returns(T.untyped) }
    def self.command(_name = nil, &blk); end

    sig { params(name: T.untyped, blk: T.untyped).returns(T.untyped) }
    def self.query(name, &blk); end

    sig { params(blk: T.untyped).returns(T.untyped) }
    def self.parameters(&blk); end

    sig { params(hash: SymbolHash).returns(T.untyped) }
    def self.call(hash = {}); end

    sig { returns(T.untyped) }
    def perform; end

    module ParamsFactory
      sig { params(params: T.untyped).returns(T.untyped) }
      def self.build(params); end
    end

    class Step < Value
      const :step, T.untyped

      sig { params(instance: T.untyped).returns(T.untyped) }
      def call(instance); end

      class Command < self
        sig { params(instance: T.untyped).returns(T.untyped) }
        def call(instance = nil); end
      end

      class Failure < self
        sig { params(instance: T.untyped).returns(T.untyped) }
        def call(instance = nil); end
      end

      class Query < self
        const :name, Symbol

        sig { params(instance: T.untyped).returns(T.untyped) }
        def call(instance = Object.new); end
      end

      class Result < self
        sig { params(instance: T.untyped).returns(T.untyped) }
        def call(instance = nil)
        end

        private

        sig { params(instance: T.untyped, value: T.untyped).returns(T.untyped) }
        def success(instance, value)
        end
      end
    end
  end

  class Params
    include T::Props
    include T::Props::Constructor

    sig { params(params: Parameters).returns(T.attached_class) }
    def self.extract(params); end
  end

  module PrivateCreation
    sig { params(klass: Class).void }
    def self.included(klass); end
  end

  class Result < Value
    include PrivateCreation

    sig { returns(M::Result::Null) }
    def self.Null; end

    sig { params(success_klass: T.untyped, error_klass: T.untyped).returns(T.untyped) }
    def self.[](success_klass, error_klass); end

    sig { returns(T.untyped) }
    def value!; end

    class Factory < T::Struct
      prop :success_klass, T.untyped
      prop :error_klass,   T.untyped

      sig { params(value: T.untyped).returns(Success) }
      def success(value); end

      sig { params(error: T.untyped).returns(Failure) }
      def failure(error); end

      private

      sig { returns(Class) }
      def success_subclass; end

      sig { returns(Class) }
      def failure_subclass; end

      sig { params(klass: Class, symbol: Symbol, sklass: T.untyped).returns(Class) }
      def klass_factory(klass, symbol, sklass); end
    end

    class Failure < self
      ValueCalledOnFailureError = Class.new(Error)
      private_constant :ValueCalledOnFailureError

      const :error, T.untyped
      private :error

      sig { returns(T.noreturn) }
      def value!; end

      sig { returns(T.untyped) }
      def error!; end

      sig { params(_block: T.untyped).returns(M::Result::Failure) }
      def and_then(&_block); end

      sig { params(block: T.untyped).returns(M::Result::Failure) }
      def or_else(&block); end
    end

    class Null < self
      sig { returns(T.noreturn) }
      def value!; end

      sig { returns(T.noreturn) }
      def error!; end

      sig { returns(Null) }
      def and_then(&_block); end

      sig { returns(Null) }
      def or_else(&_block); end
    end

    class Success < self
      ErrorCalledOnSuccessError = Class.new(Error)
      private_constant :ErrorCalledOnSuccessError

      const :value, T.untyped
      private :value

      sig { returns(T.untyped) }
      def value!; end

      sig { returns(T.noreturn) }
      def error!; end

      sig { params(block: T.untyped).returns(T.untyped) }
      def and_then(&block); end

      sig { params(_block: T.untyped).returns(T.untyped) }
      def or_else(&_block); end
    end
  end

  class Service
    include T::Props
    include T::Props::Constructor
    include PrivateCreation

    abstract!

    sig { params(hash: SymbolHash).returns(T.untyped) }
    def self.call(hash = {}); end
    class << self; alias_method :[], :call; end

    sig { params(args: Symbol, opts: T.untyped).void }
    def self.arguments(*args, **opts); end

    private

    sig { abstract.returns(T.untyped) }
    def perform; end
  end

  module Utils
    sig { params(errors: T.untyped).returns(T.untyped) }
    def self.cast_to_errors(*errors); end

    sig { params(type: T.untyped).returns(T.untyped) }
    def self.cast_to_error(type); end

    sig { params(error: T.untyped).returns(T.untyped) }
    def self.cast_union_to_errors(error); end

    sig { params(failure_klass: T.untyped).returns(T.untyped) }
    def self.errors_rescue_module(failure_klass); end

    sig { params(error: T.untyped).returns(T.untyped) }
    def self.flatten_union(error); end
  end

  class Value
    include T::Props
    include T::Props::Constructor
    include T::Struct::ActsAsComparable

    sig { params(hash: SymbolHash).void }
    def initialize(hash = {}); end
  end
end
M = Muina
