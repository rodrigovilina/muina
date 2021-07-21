# typed: strict
# frozen_string_literal: true

module Muina
  class Error < StandardError; end

  class TestError < StandardError; end

  sig { params(value: T.untyped).returns(M::Result::Success) }
  def self.Success(value)
  end

  sig { params(error: T.untyped).returns(M::Result::Failure) }
  def self.Failure(error)
  end

  sig { params(blk: T.untyped).returns(M::Result) }
  def self.Result(&blk)
  end
end
M = Muina
