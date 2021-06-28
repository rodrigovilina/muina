# typed: strong
M = Muina

class Module
  include T::Sig
end

module Muina
  Classes = T.type_alias { T.any(Class, T::Array[Class]) }
  UNIT = T.let(Unit.instance, Unit)
  VERSION = '0.2.0'

  class Error < StandardError
  end

  class TestError < StandardError
  end

  class Params
    include T::Props
    include T::Props::Constructor

    sig { params(params: T.untyped).returns(T.untyped) }
    def self.extract(params); end
  end

  module PrivateCreation
    sig { params(klass: T.untyped).returns(T.untyped) }
    def self.included(klass); end
  end

  class Service
    abstract!

    include T::Props
    include T::Props::Constructor
    include PrivateCreation
    extend T::Helpers

    sig { params(hash: T.untyped).returns(T.untyped) }
    def self.call(hash = {}); end

    sig { params(args: Symbol, opts: T.untyped).void }
    def self.arguments(*args, **opts); end

    sig { abstract.returns(T.untyped) }
    def perform; end
  end

  class Unit
    include Singleton
  end

  module Utils
    sig { params(errors: T.untyped).returns(T::Array[T.untyped]) }
    def self.cast_to_errors(*errors); end

    sig { params(type: BasicObject).returns(T.untyped) }
    def self.cast_to_error(type); end

    sig { params(error: T::Types::Union).returns(T::Array[T.untyped]) }
    def self.cast_union_to_errors(error); end

    sig { params(failure_klass: Classes).returns(Module) }
    def self.errors_rescue_module(failure_klass); end
  end

  class Value
    include T::Props
    include T::Props::Constructor
    include T::Struct::ActsAsComparable

    sig { params(hash: T::Hash[Symbol, T.untyped]).void }
    def initialize(hash = {}); end
  end

  class Action < Params
    include T::Props
    include T::Props::Constructor

    sig { returns(T.untyped) }
    def self.steps; end

    sig { returns(T.untyped) }
    def self.success; end

    sig { returns(T.untyped) }
    def self.failure; end

    sig { returns(T.untyped) }
    def self.result_set; end

    sig { params(hash: T.untyped).returns(T.untyped) }
    def self.call(hash = {}); end

    sig { params(name: T.untyped, step: T.untyped).returns(T.untyped) }
    def self.query(name, &step); end

    sig { params(step: T.untyped).returns(T.untyped) }
    def self.result(&step); end

    sig { returns(T.untyped) }
    def perform; end

    class Query < Value
      sig { params(instance: Object).returns(T.untyped) }
      def call(instance = Object); end
    end

    class Step < Value
      sig { params(instance: Object).returns(Result) }
      def call(instance = nil); end

      sig { params(error: T.untyped).returns(Result) }
      def fail!(error); end
    end
  end

  class Result < Value
    include PrivateCreation

    sig { params(success_klass: T.untyped, error_klass: T.untyped).returns(T.untyped) }
    def self.[](success_klass, error_klass); end

    sig { params(value: T.untyped).returns(T.untyped) }
    def self.success(value); end

    sig { params(error: T.untyped).returns(T.untyped) }
    def self.failure(error); end

    sig { returns(T.untyped) }
    def value!; end

    sig { returns(T.untyped) }
    def error!; end

    sig { params(block: T.untyped).returns(T.untyped) }
    def and_then(&block); end

    sig { params(block: T.untyped).returns(T.untyped) }
    def or_else(&block); end

    sig { params(hash: T.untyped).returns(T.untyped) }
    def initialize(hash = {}); end
  end
end
