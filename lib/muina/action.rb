# typed: strict
# frozen_string_literal: true

module Muina
  # Two tracked result based operation
  class Action
    include T::Props
    include T::Props::Constructor

    class DoubleResultError < Error; end

    class DoubleFailureError < Error; end

    private_class_method :new

    def self.steps
      @steps ||= []
    end

    def self.extract(params)
      new(TypedParams[parameters].new.extract!(ParamsFactory.build(params)).serialize.symbolize_keys)
    end
    private_class_method :extract

    def self.result(&blk)
      raise DoubleResultError if @__result_set__

      steps << Step::Result.new(step: blk)

      @__result_set__ = true
    end
    private_class_method :result

    def self.failure(&blk)
      raise DoubleFailureError if @__failure_set__

      steps << Step::Failure.new(step: blk)

      @__failure_set__ = true
    end
    private_class_method :failure

    def self.command(_name = nil, &blk)
      steps << Step::Command.new(step: blk)
    end
    private_class_method :command

    def self.query(name, type = T.untyped, &blk)
      const name, type
      steps << Step::Query.new(name: name, step: blk)
    end
    private_class_method :query

    def self.parameters(&blk)
      @parameters ||= Class.new(T::Struct)
      parameters.instance_eval(&blk) if blk
      instance_eval(&blk) if blk
      @parameters
    end

    def self.call(hash = {})
      extract(hash).__send__(:perform)
    end

    private

    def perform
      self.class.steps.each { |step| step.call(self) }

      @__result__ || @__failure__ || Result::Null()
    end
  end
end
