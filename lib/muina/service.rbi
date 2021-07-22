# typed: strict
# frozen_string_literal: true

module Muina
  # Simple Service Object compatible with MiniService::Base
  class Service
    extend T::Helpers
    include T::Props
    include T::Props::Constructor
    include PrivateCreation

    abstract!

    sig { params(hash: SymbolHash).returns(T.untyped) }
    def self.call(hash = {})
    end
    class << self; alias_method :[], :call; end

    sig { params(args: Symbol, opts: T.untyped).void }
    def self.arguments(*args, **opts)
    end

    private

    sig { abstract.returns(T.untyped) }
    def perform; end
  end
end
