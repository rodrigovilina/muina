# typed: strong
# frozen_string_literal: true

M = Muina

class Module
  include T::Sig
end

module Muina
  Any = T.type_alias { T.untyped }
  Classes = T.type_alias { T.any(Class, T::Array[Class]) }
  Parameters = T.type_alias { T.any(UntypedHash, ActionController::Parameters) }
  SymbolHash = T.type_alias { T::Hash[Symbol, T.untyped] }
  UntypedArray = T.type_alias { T::Array[T.untyped] }
  UntypedHash = T.type_alias { T::Hash[T.untyped, T.untyped] }
  UNIT = T.let(Unit.instance, Unit)
  VERSION = '0.2.7'

  class Error < StandardError; end

  sig { params(value: T.untyped).returns(Muina::Result::Success) }
  def self.Success(value); end

  sig { params(error: T.untyped).returns(Muina::Result::Failure) }
  def self.Failure(error); end

  sig { params(blk: T.untyped).returns(T.any(Muina::Result::Success, Muina::Result::Failure)) }
  def self.Result(&blk); end

  class Action
    include T::Props
    include T::Props::Constructor

    class DoubleResultError < Error
    end

    @steps           = T.let(@steps, T.nilable(T::Array[Muina::Action::Step]))
    @parameters      = T.let(@parameters, T.untyped)
    @__result_set__  = T.let(@__result_set__, T::Boolean)
    @__failure_set__ = T.let(@__failure_set__, T::Boolean)

    def initialize(hash)
      @__failure__ = T.let(@__failure__, T.nilable(Muina::Result::Failure))
      @__result__  = T.let(@__result__, T.nilable(Muina::Result::Success))
    end

    sig { returns(T::Array[Muina::Action::Step]) }
    def self.steps; end

    sig { params(params: T.untyped).returns(T.untyped) }
    def self.extract(params); end

    sig { params(blk: T.untyped).returns(T.untyped) }
    def self.result(&blk); end

    sig { params(blk: T.untyped).returns(T.untyped) }
    def self.failure(&blk); end

    sig { params(_name: T.untyped, blk: T.untyped).returns(T.untyped) }
    def self.command(_name = nil, &blk); end

    sig { params(name: T.untyped, type: T.untyped, blk: T.untyped).returns(T.untyped) }
    def self.query(name, type, &blk); end

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

      sig { params(action: T.untyped).returns(T.untyped) }
      def call(action); end

      class Command < self
        sig { params(action: T.untyped).returns(T.untyped) }
        def call(action); end

        private

        sig { void }
        def success; end

        sig { params(action: T.untyped, result: T.untyped).void }
        def failure(action, result); end
      end

      class Failure < self
        sig { params(action: T.untyped).returns(T.untyped) }
        def call(action); end
      end

      class Query < self
        const :name, Symbol

        sig { params(action: T.untyped).void }
        def call(action); end

        private

        sig { params(action: T.untyped, result: T.untyped).void }
        def success(action, result); end

        sig { params(action: T.untyped, result: T.untyped).void }
        def failure(action, result); end
      end

      class Result < self
        class Caller
          class Successful
            sig { params(action: T.untyped, result: T.untyped).void }
            def initialize(action, result)
              @action = T.let(@action, Muina::Action)
              @result = T.let(@result, Muina::Result)
            end

            sig { void }
            def call; end
          end

          class Failed
            sig { params(action: T.untyped, result: T.untyped).void }
            def initialize(action, result)
              @action = T.let(@action, Muina::Action)
              @result = T.let(@result, Muina::Result)
            end

            sig { void }
            def call; end
          end

          sig do
            params(action: T.untyped, step: T.untyped)
              .returns(
                T.any(Muina::Action::Step::Result::Caller::Successful, Muina::Action::Step::Result::Caller::Failed)
              )
          end
          def self.for(action, step); end
        end

        sig { params(action: T.untyped).void }
        def call(action); end

        private

        sig { params(action: T.untyped, value: T.untyped).void }
        def success(action, value); end

        sig { params(action: T.untyped, value: T.untyped).void }
        def failure(action, value); end
      end
    end
  end

  class Entity
    sig { returns(Muina::SymbolHash) }
    def serialize; end

    sig { params(hash: SymbolHash).returns(Muina::Entity) }
    def with(hash); end
  end

  class Params
    include T::Props
    include T::Props::Constructor

    sig { params(params: Parameters).returns(T.attached_class) }
    def self.extract(params); end

    sig { params(other: Class).returns(T::Boolean) }
    def self.<(other); end
  end

  module PrivateCreation
    sig { params(klass: Class).void }
    def self.included(klass); end
  end

  class Result < Value
    include PrivateCreation

    sig { returns(Muina::Result::Null) }
    def self.Null; end

    sig { params(success_klass: T.untyped, error_klass: T.untyped).returns(T.untyped) }
    def self.[](success_klass, error_klass); end

    sig { returns(T.untyped) }
    def value!; end

    class Factory < T::Struct
      prop :success_klass, T.any(Classes, T::Types::Base)
      prop :error_klass,   T.any(Classes, T::Types::Base)

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

      const :error, T.untyped

      sig { returns(T.noreturn) }
      def value!; end

      sig { returns(T.untyped) }
      def error!; end

      sig { params(_block: T.untyped).returns(Muina::Result::Failure) }
      def and_then(&_block); end

      sig { params(block: T.untyped).returns(Muina::Result::Failure) }
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

      const :value, T.untyped

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

    sig { params(hash: SymbolHash).returns(T.untyped) }
    def self.call(hash = {}); end
    class << self; alias_method :[], :call; end

    sig { params(args: Symbol, opts: T.untyped).void }
    def self.arguments(*args, **opts); end

    private

    sig { returns(T.untyped) }
    def perform; end
  end

  class Unit
    include Singleton
  end

  class Value
    include T::Props
    include T::Props::Constructor
    include T::Struct::ActsAsComparable

    sig { params(hash: SymbolHash).void }
    def initialize(hash = {}); end

    sig { returns(Muina::SymbolHash) }
    def serialize; end

    sig { params(hash: SymbolHash).returns(Muina::Value) }
    def with(hash); end
  end
end
