# typed: strict
# frozen_string_literal: true

module Muina
  # Casting utils
  module Utils
    T::Sig::WithoutRuntime.sig { params(errors: T.untyped).returns(T::Array[T.untyped]) }
    def self.cast_to_errors(*errors)
      errors
        .flat_map { |error| error.instance_of?(T::Types::Union) ? cast_union_to_errors(error) : error }
        .map { |error| cast_to_error(error) }.uniq
    end

    T::Sig::WithoutRuntime.sig { params(type: BasicObject).returns(T.untyped) }
    def self.cast_to_error(type) # rubocop:disable Metrics/MethodLength
      case type
      when T::Types::Simple then type.raw_type
      when T::Types::Untyped then StandardError
      when Module then type
      else raise Error
      end
    end

    T::Sig::WithoutRuntime.sig { params(error: T::Types::Union).returns(T::Array[T.untyped]) }
    def self.cast_union_to_errors(error)
      error.types.map { |type| cast_to_error(type) }
    end

    T::Sig::WithoutRuntime.sig { params(failure_klass: Classes).returns(Module) }
    def self.errors_rescue_module(failure_klass) # rubocop:disable Metrics/MethodLength
      failures = cast_to_errors(failure_klass)

      Class.new { @failures = T.let(failures, T.untyped) }.tap do |klass|
        klass.define_singleton_method(:===) do |exception|
          [*@failures].any? { |failure| exception.instance_of?(failure) }
        end
      end
    end
  end
end
