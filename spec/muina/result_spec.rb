# frozen_string_literal: true

RSpec.describe Muina::Result do
  describe '.success' do
    it 'returns a Success', :aggregate_failures do
      result = described_class.success(true)

      expect(result).to be_a described_class::Success
      expect(result.value!).to be true
    end
  end

  describe '.failure' do
    it 'returns a Failure', :aggregate_failures do
      result = described_class.failure(true)

      expect(result).to be_a described_class::Failure
      expect(result.error!).to be true
    end
  end
end
