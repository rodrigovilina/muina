# typed: false
# frozen_string_literal: true

RSpec.describe Muina::Action do
  describe '.failure' do
    it do
      klass = Class.new(described_class) do
        failure { nil }
      end

      expect(klass.steps.first.step).to be_a(Proc)
    end
  end
end
