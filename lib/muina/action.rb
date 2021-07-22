# typed: strict
# frozen_string_literal: true

module Muina
  # Two tracked result based operation
  class Action
    include T::Props
    include T::Props::Constructor

    class DoubleResultError < Error
    end

    private_class_method :new

    def self.steps
      @steps ||= []
    end

    def self.extract(params)
      new(TypedParams[parameters].new.extract!(ParamsFactory.build(params)).serialize.symbolize_keys)
    end
    private_class_method :extract

    def self.result(&blk)
      raise DoubleResultError if @result_set

      steps << Step::Result.new(step: blk)

      @result_set = true
    end
    private_class_method :result

    def self.failure(&blk)
      steps << Step::Failure.new(step: blk)
    end
    private_class_method :failure

    def self.command(_name = nil, &blk)
      steps << Step::Command.new(step: blk)
    end
    private_class_method :command

    def self.query(name, &blk)
      const name, T.untyped
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
      self.class.steps.map { |step| step.call(self) }.compact.last || Result::Null()
    end
  end
end
