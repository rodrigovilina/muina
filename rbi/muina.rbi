# typed: strong
M = Muina

class Module
  include T::Sig
end

module Muina
  Classes = T.type_alias { T.any(Class, T::Array[Class]) }
  Unit = Class.new do
    include Singleton
  end
  VERSION = '0.1.0'

  class Error < StandardError
  end

  class TestError < StandardError
  end

  class Params
    include T::Props
    include T::Props::Constructor

    sig { params(params: T.any(T::Hash[T.untyped, T.untyped], ActionController::Parameters)).returns(T.attached_class) }
    def self.extract(params); end
  end

  module PrivateCreation
    sig { params(klass: Module).void }
    def self.included(klass); end
  end

  class Result < Value
    include PrivateCreation

    sig { params(success_klass: T.untyped, error_klass: T.untyped).returns(T.untyped) }
    def self.[](success_klass, error_klass); end

    sig { params(value: T.untyped).returns(T.attached_class) }
    def self.success(value); end

    sig { params(error: T.untyped).returns(T.attached_class) }
    def self.failure(error); end
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

  class Value
    include T::Props
    include T::Props::Constructor
    include T::Struct::ActsAsComparable

    sig { params(hash: T::Hash[Symbol, T.untyped]).void }
    def initialize(hash = {}); end
  end
end
