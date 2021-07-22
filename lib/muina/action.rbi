# typed: strict
# frozen_string_literal: true

module Muina
  class Action
    include T::Props
    include T::Props::Constructor

    class DoubleResultError < Error
    end

    @steps      = T.let(@steps, T.nilable(T::Array[M::Action::Step]))
    @parameters = T.let(@parameters, T.untyped)
    @result_set = T.let(@result_set, T::Boolean)

    sig { returns(T::Array[M::Action::Step]) }
    def self.steps
    end

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
  end
end
