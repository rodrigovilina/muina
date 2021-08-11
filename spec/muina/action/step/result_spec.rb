# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action::Step::Result do
  describe '#call' do
    it 'rescues the raised error if type matches', aggregate_failures: true do
      expect(described_class.new(step: proc { raise KeyError }).call).to be_a(Muina::Result)
    end

    it 'rescues standard error on untyped failure', aggregate_failures: true do
      step = described_class.new(step: proc { raise StandardError })
      result = step.call
      expect(result).to be_a(Muina::Result)
      expect(result.error!).to be_a(StandardError)
    end
  end
end
