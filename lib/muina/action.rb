# typed: strict
# frozen_string_literal: true

module Muina
  # Feature implementation with typesafe params and wrapped up failures
  class Action
    include T::Props
    include T::Props::Constructor

    def self.steps
      @steps ||= []
    end

    def self.success
      @success ||= T.untyped
    end

    def self.failure
      @failure ||= T.untyped
    end

    def self.call(hash = {})
      new(hash).perform
    end

    def self.query(name, &step)
      const name, T.untyped
      steps << Query.new(name: name, step: step)
    end

    def self.result(&step)
      steps << Step.new(step: step, success: success, failure: failure)
    end

    def perform
      self.class.steps.map { |step| step.call(self) }.last
    end
  end
end
