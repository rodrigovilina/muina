# typed: strict
# frozen_string_literal: true

module Muina
  # Casting utils
  module Utils
    def self.cast_to_errors(*errors)
      errors
        .flat_map { |error| flatten_union(error) }
        .map      { |error| cast_to_error(error) }.uniq
    end

    def self.cast_to_error(type) # rubocop:disable Metrics/MethodLength
      case type
      when T::Types::Simple then type.raw_type
      when T::Types::Untyped then StandardError
      when Module then type
      else raise Error
      end
    end

    def self.cast_union_to_errors(error)
      error.types.map { |type| cast_to_error(type) }
    end

    def self.errors_rescue_module(failure_klass) # rubocop:disable Metrics/MethodLength
      failures = cast_to_errors(failure_klass)

      Class.new { @failures = T.let(failures, T.untyped) }.tap do |klass|
        klass.define_singleton_method(:===) do |exception|
          @failures.any? { |failure| exception.instance_of?(failure) }
        end
      end
    end

    def self.flatten_union(error)
      case error
      when T::Types::Union then cast_union_to_errors(error)
      else error
      end
    end
  end
end
