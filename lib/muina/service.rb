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

    T::Sig::WithoutRuntime.sig { params(hash: SymbolHash).returns(T.untyped) }
    def self.call(hash = {})
      new(hash).__send__(:perform)
    end
    class << self; alias_method :[], :call; end

    T::Sig::WithoutRuntime.sig { params(args: Symbol, opts: T.untyped).void }
    def self.arguments(*args, **opts)
      args.each { |arg| const arg, T.untyped }
      opts.each { |key, value| const key, T.untyped, default: value }
    end

    private

    sig { abstract.returns(T.untyped) }
    def perform; end
  end
end
